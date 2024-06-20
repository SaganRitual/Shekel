// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit
import SwiftUI

struct SpriteKitView: NSViewRepresentable {
    @EnvironmentObject var gameController: GameController

    class Coordinator {
        var observation: NSKeyValueObservation?
    }

    func dismantleNSView(_ nsView: SKView, coordinator: Coordinator) {
        coordinator.observation = nil
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeNSView(context: Context) -> SKView {
        let view = SKView()

        view.presentScene(gameController.gameScene)

        let observation = view.observe(\.frame) { view, _ in
            view.trackingAreas.forEach(view.removeTrackingArea)

            let trackingArea = NSTrackingArea(rect: view.bounds,
                                            options: [.mouseMoved, .activeInKeyWindow],
                                            owner: view, userInfo: nil)
            view.addTrackingArea(trackingArea)
        }

        context.coordinator.observation = observation

        return view
    }

    func updateNSView(_ nsView: SKView, context: Context) {

    }
}
