// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

protocol ActionTokenViewProtocol: View {
    var duration: Double { get }
}

struct MoveActionTokenView: View, ActionTokenViewProtocol {
    let duration: Double
    let targetPosition: CGPoint

    var body: some View {
        VStack(alignment: .center) {
            Text("Move to \(Utility.mousePositionString(targetPosition, 0))")
            Text(String(format: "%.1fs", duration))
        }
        .padding()
        .background(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15), style: .circular).fill(.black))
    }
}

struct RotationActionTokenView: View, ActionTokenViewProtocol {
    let duration: Double
    let targetRotation: CGFloat

    var body: some View {
        VStack(alignment: .center) {
            Text("Rotate to \(String(format: "%.2f", targetRotation))")
            Text(String(format: "%.2f", duration))
        }
        .padding()
        .background(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15), style: .circular).fill(.black))
    }
}

struct ScaleActionTokenView: View, ActionTokenViewProtocol {
    let duration: Double
    let targetScale: CGFloat

    var body: some View {
        VStack(alignment: .center) {
            Text("Scale to \(String(format: "%.2f", targetScale))")
            Text(String(format: "%.2f", duration))
        }
        .padding()
        .background(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15), style: .circular).fill(.black))
    }
}
