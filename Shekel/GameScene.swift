// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit
 
class GameScene: SKScene {
    var gameController: GameController!
    let selectionMarquee: SelectionMarquee

    let cameraNode = SKCameraNode()
    let entitiesNode = SKNode()

    var mouseState = MouseState.idle
    var hotDragTarget: GameEntity?
    var hotDragSubhandle: SelectionHaloRS.Directions?

    enum MouseState {
        case dragBackground, dragHandle, dragSubhandle, idle, mouseDown
    }

    init(_ size: CGSize, _ selectionMarquee: SelectionMarquee) {
        self.selectionMarquee = selectionMarquee
        super.init(size: size)

        isUserInteractionEnabled = true

        backgroundColor = .black

        physicsWorld.gravity = .zero
        physicsWorld.speed = 0

        addChild(cameraNode)
        camera = cameraNode

//        cameraNode.position = gameController.playgroundState.cameraPosition
//        cameraNode.setScale(gameController.playgroundState.cameraScale)

        addChild(entitiesNode)
        addChild(selectionMarquee.marqueeRootNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var dcsCount = 0
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)

        if self.size == .zero {
            Self.dcsCount += 1

            print(".zero \(Self.dcsCount)")
            return
        }

        Self.dcsCount += 1
        print("old size \(oldSize) new size \(self.size), count \(Self.dcsCount)")
        Task { @MainActor in
            gameController?.playgroundState.viewSize = self.size
        }
    }

    override func didMove(to view: SKView) {
    }
}
