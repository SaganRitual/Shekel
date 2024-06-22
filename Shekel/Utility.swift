// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

enum Utility {
    static func mousePositionString(_ positionInView: CGPoint, _ decimals: Int = 2) -> String {
        let vx = String(format: "%.\(decimals)f", positionInView.x)
        let vy = String(format: "%.\(decimals)f", positionInView.y)

        return "(\(vx), \(vy))"
    }
}
