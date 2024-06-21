// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit
 
class GameScene: SKScene {
    var playgroundState: PlaygroundState!
    var gameController: GameController!
    var selectionMarquee: SelectionMarquee!

    let cameraNode = SKCameraNode()
    let entitiesNode = SKNode()

    var mouseState = MouseState.idle
    var hotDragTarget: GameEntity?
    var hotDragSubhandle: SelectionHaloRS.Directions?

    enum MouseState {
        case dragBackground, dragHandle, dragSubhandle, idle, mouseDown
    }

    init(_ size: CGSize) {
        super.init(size: size)

        isUserInteractionEnabled = true

        backgroundColor = .black

        physicsWorld.gravity = .zero
        physicsWorld.speed = 0

        addChild(cameraNode)
        camera = cameraNode

        addChild(entitiesNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func postInit(_ gameController: GameController, _ playgroundState: PlaygroundState, _ selectionMarquee: SelectionMarquee) {
        self.gameController = gameController
        self.playgroundState = playgroundState
        self.selectionMarquee = selectionMarquee

        cameraNode.position = playgroundState.cameraPosition
        cameraNode.setScale(playgroundState.cameraScale)

        addChild(selectionMarquee.marqueeRootNode)
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
            playgroundState.viewSize = self.size
        }
    }

    override func didMove(to view: SKView) {
    }
}
