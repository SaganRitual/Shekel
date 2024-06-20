// We are a way for the cosmos to know itself. -- C. Sagan

import AppKit
import Foundation
import SpriteKit

struct MouseDispatch {
    let location: CGPoint
    let control: Bool
    let shift: Bool

    init(from event: NSEvent, scene: SKScene) {
        self.location = event.location(in: scene)
        self.control = event.modifierFlags.contains(.control)
        self.shift = event.modifierFlags.contains(.shift)
    }
}
