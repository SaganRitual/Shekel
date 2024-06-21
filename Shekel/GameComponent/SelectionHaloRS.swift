// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class SelectionHaloRS: SelectionHalo {
    enum Directions: Int, CaseIterable { case n = 0, e = 1, s = 2, w = 3 }

    let subhandles: [Directions: Subhandle]

    init(_ subhandles: [Directions: Subhandle]) {
        self.subhandles = subhandles
        super.init()

        subhandles.values.forEach { sceneNode.addChild($0.sceneNode) }
    }

    func getSubhandleDirection(_ node: SKNode) -> Directions? {
        subhandles.first(where: { $0.value.sceneNode === node })?.key
    }

    override func setScale(_ scale: CGFloat) {
        subhandles.values.forEach { $0.sceneNode.setScale(1 / scale) }
        super.setScale(scale)
    }

    static func make() -> SelectionHaloRS {
        var subhandles = [Directions: Subhandle]()
        Directions.allCases.forEach { direction in
            subhandles[direction] = Subhandle(direction, Self.radius)
        }

        return SelectionHaloRS(subhandles)
    }
}

extension SelectionHaloRS {

    class Subhandle: GameEntityView {
        static let radius = 5.0

        let direction: Directions

        init(_ direction: Directions, _ parentRadius: CGFloat) {
            self.direction = direction

            let shape = SKShapeNode(circleOfRadius: Self.radius)

            shape.isAntialiased = true
            shape.strokeColor = .clear
            shape.blendMode = .replace
            shape.isHidden = false
            shape.zPosition = 11

            Self.deploy(shape, direction, parentRadius)

            super.init(sceneNode: shape)
        }
    }

}

private extension SelectionHaloRS.Subhandle {

    static func deploy(_ shape: SKShapeNode, _ direction: SelectionHaloRS.Directions, _ parentRadius: CGFloat) {
        switch direction {
        case .n:
            shape.fillColor = .red
            shape.position = CGPoint(x: 0, y: parentRadius)
        case .e:
            shape.fillColor = .green
            shape.position = CGPoint(x: parentRadius, y: 0)
        case .s:
            shape.fillColor = .blue
            shape.position = CGPoint(x: 0, y: -parentRadius)
        case .w:
            shape.fillColor = .yellow
            shape.position = CGPoint(x: -parentRadius, y: 0)
        }
    }

}
