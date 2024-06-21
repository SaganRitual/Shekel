// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

enum Utility {
    static func mousePositionString(_ positionInView: CGPoint) -> String {
        let vx = String(format: "%.2f", positionInView.x)
        let vy = String(format: "%.2f", positionInView.y)

        return "(\(vx), \(vy))"
    }
}
