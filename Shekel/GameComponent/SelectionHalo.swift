// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class SelectionHalo: GameEntityView {
    static let radius = 25.0

    var dragAnchor: CGPoint = .zero
    var isSelected: Bool { !sceneNode.isHidden }

    init() {
        let shape = SKShapeNode(circleOfRadius: Self.radius)

        shape.lineWidth = 1
        shape.strokeColor = .green
        shape.fillColor = .clear
        shape.blendMode = .replace
        shape.isHidden = true
        shape.name = "MoveHandleShape"

        super.init(sceneNode: shape)
    }

    func deselect() { sceneNode.isHidden = true }
    func select() { sceneNode.isHidden = false }
    func toggleSelect() { sceneNode.isHidden = !sceneNode.isHidden }
}
