// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class GameEntity {
    let uuid = UUID()

    var dragAnchor: CGPoint?
    var dragging = false

    var rotationAnchor: CGFloat?
    var scaleAnchor: CGFloat?

    var halo: SelectionHalo? { nil }

    var physicsBody: SKPhysicsBody? {
        get { view?.sceneNode.physicsBody }
        set { view?.sceneNode.physicsBody = newValue }
    }

    var position: CGPoint {
        get { view?.sceneNode.position ?? .zero }
        set {
            view?.sceneNode.position = newValue
            halo?.sceneNode.position = newValue
        }
    }

    var rotation: CGFloat {
        get { view?.sceneNode.zRotation ?? 0 }
        set {
            view?.sceneNode.zRotation = newValue
            halo?.sceneNode.zRotation = newValue
        }
    }

    var scale: CGFloat {
        get {
            guard let sn = view?.sceneNode else { return 0 }
            return sn.xScale
        }

        set {
            view?.sceneNode.setScale(newValue)
            halo?.setScale(newValue)
        }
    }

    var view: GameEntityView? { nil }

    func addActionToken(_ token: any ActionTokenProtocol) { }
    func getActionTokens() -> [ActionTokenContainer] { [] }

    func restoreActionAnchors() { }

    func setAssignActionsMode(_ setIt: Bool) {
        halo?.setSelectionMode(setIt ? .assignActions : .normal)
    }

    func cancelActionsMode() { }
    func commitActions(duration: TimeInterval) { }
    func startActionsMode() { }
}

extension GameEntity: Equatable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    static func == (lhs: GameEntity, rhs: GameEntity) -> Bool {
        return lhs === rhs
    }
}
