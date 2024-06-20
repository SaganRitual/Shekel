// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class GameEntityView {
    let sceneNode: SKNode

    init(sceneNode: SKNode) {
        self.sceneNode = sceneNode
    }
}

class GremlinView: GameEntityView {
    init() {
        let sceneNode = SKSpriteNode(imageNamed: "cyclops")
        super.init(sceneNode: sceneNode)
    }
}

class WaypointView: GameEntityView {
    init() {
        let sceneNode = SKSpriteNode(imageNamed: "waypoint")
        super.init(sceneNode: sceneNode)
    }
}
