// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit
import SwiftUI

class MySKView: SKView {
    var trackingArea: NSTrackingArea?

    override var acceptsFirstResponder: Bool { return true }

    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        self.nextResponder?.mouseDown(with: event)
    }

    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        self.nextResponder?.mouseDragged(with: event)
    }

    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        self.nextResponder?.mouseUp(with: event)
    }

    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        self.nextResponder?.mouseMoved(with: event)
    }

    override func updateTrackingAreas() {
        super.updateTrackingAreas()

        if let existingArea = trackingArea {
            removeTrackingArea(existingArea)
        }

        let options: NSTrackingArea.Options = [
            .mouseMoved,
            .activeInKeyWindow,
            .inVisibleRect
        ]

        trackingArea = NSTrackingArea(rect: bounds, options: options, owner: self, userInfo: nil)
        addTrackingArea(trackingArea!)
    }
}

struct SpriteKitView: NSViewRepresentable {
    @EnvironmentObject var gameController: GameController

    func makeNSView(context: Context) -> MySKView {
        let view = MySKView()

        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        view.preferredFramesPerSecond = 60
        view.shouldCullNonVisibleNodes = false
        view.isAsynchronous = false
        view.showsPhysics = true
        view.showsFields = true
        view.showsDrawCount = true
        view.showsQuadCount = true
        view.isAsynchronous = true
        view.allowsTransparency = true

        let gameScene = gameController.installGameScene(view.bounds.size)

        view.presentScene(gameScene)

        DispatchQueue.main.async {
            view.window?.makeFirstResponder(view)
        }

        return view
    }

    func updateNSView(_ nsView: MySKView, context: Context) {
        // Update SKView properties here if needed
    }
}
