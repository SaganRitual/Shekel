// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

final class Gremlin: GameEntity {
    private let halo_: SelectionHalo
    override var halo: SelectionHalo? { halo_ }

    private let view_: GameEntityView
    override var view: GameEntityView? { view_ }

    var actionTokens = [any ActionTokenProtocol]()

    var anchorMoveAction = CGPoint.zero
    var anchorRotateAction = CGFloat.zero
    var anchorScaleAction = CGFloat.zero

    var viewSpriteNode: SKSpriteNode {
        view!.sceneNode as! SKSpriteNode
    }

    init(halo halo_: SelectionHalo, view view_: GameEntityView) {
        self.halo_ = halo_
        self.view_ = view_
    }

    override func addActionToken(_ token: any ActionTokenProtocol) {
        actionTokens.append(token)
    }

    override func cancelActionsMode() {
        setAssignActionsMode(false)
        restoreActionAnchors()
    }

    override func commitActions(duration: TimeInterval) {
        setAssignActionsMode(false)

        if let dragAnchor = dragAnchor, dragAnchor != position {
            let t = MoveActionToken(duration: duration, targetPosition: position)
            addActionToken(t)
        }

        if let rotationAnchor = rotationAnchor, rotationAnchor != rotation {
            let t = RotateActionToken(duration: duration, targetRotation: rotation)
            addActionToken(t)
        }

        if let scaleAnchor = scaleAnchor, scaleAnchor != scale {
            let t = ScaleActionToken(duration: duration, targetScale: scale)
            addActionToken(t)
        }

        restoreActionAnchors()
     }

    override func getActionTokens() -> [ActionTokenContainer] {
        actionTokens.map { ActionTokenContainer(token: $0) }
    }

    override func restoreActionAnchors() {
        var actions = [SKAction]()

        if anchorMoveAction != position {
            let a = SKAction.move(to: anchorMoveAction, duration: 0.5)
            actions.append(a)
        }

        if anchorRotateAction != rotation {
            let a = SKAction.rotate(toAngle: anchorRotateAction, duration: 0.5)
            actions.append(a)
        }

        if anchorScaleAction != scale {
            let a = SKAction.scale(to: anchorScaleAction, duration: 0.5)
            actions.append(a)
        }

        if !actions.isEmpty {
            let group = SKAction.group(actions)
            halo!.sceneNode.run(group)
            view!.sceneNode.run(group)
        }
    }

    override func startActionsMode() {
        if actionTokens.isEmpty {
            anchorMoveAction = position
            anchorRotateAction = rotation
            anchorScaleAction = scale
        } else {
            if let lastMove = actionTokens.last(where: { $0 is MoveActionToken }) as? MoveActionToken {
                position = lastMove.targetPosition
            }

            if let lastRotate = actionTokens.last(where: { $0 is RotateActionToken }) as? RotateActionToken {
                rotation = lastRotate.targetRotation
            }

            if let lastScale = actionTokens.last(where: { $0 is ScaleActionToken }) as? ScaleActionToken {
                scale = lastScale.targetScale
            }
        }

        setAssignActionsMode(true)
    }

    static func make(at position: CGPoint) -> Gremlin {
        let halo = SelectionHaloRS.make()
        let view = GremlinView()
        let gremlin = Gremlin(halo: halo, view: view)

        halo.sceneNode.setOwnerEntity(gremlin)
        view.sceneNode.setOwnerEntity(gremlin)

        halo.subhandles.values.forEach { sh in
            sh.sceneNode.setOwnerEntity(gremlin)
        }

        gremlin.position = position

        return gremlin
    }
}
