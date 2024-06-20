// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class GameEntity {
    let uuid = UUID()

    var dragAnchor: CGPoint?
    var dragging = false

    var halo: SelectionHalo? { nil }

    var position: CGPoint {
        get { view?.sceneNode.position ?? .zero }
        set {
            view?.sceneNode.position = newValue
            halo?.sceneNode.position = newValue
        }
    }

    var view: GameEntityView? { nil }
}

extension GameEntity: Equatable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    static func == (lhs: GameEntity, rhs: GameEntity) -> Bool {
        return lhs === rhs
    }
}
