// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

class GameComponent {
    var position: CGPoint {
        get { view?.sceneNode.position ?? .zero }
        set { view?.sceneNode.position = newValue }
    }

    var view: GameEntityView? { nil }
}
