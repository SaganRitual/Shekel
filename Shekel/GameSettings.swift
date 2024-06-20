// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SwiftUI

class GameSettings: ObservableObject {
    @Published var cameraPosition: CGPoint = .zero
    @Published var cameraScale: CGFloat = 1
    @Published var mousePosition: CGPoint = .zero
}
