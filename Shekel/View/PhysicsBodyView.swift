// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsBodyView: View {
    let physicsBody: SKPhysicsBody

    @State private var affectedByGravity = false
    @State private var allowsRotation = false
    @State private var isDynamic = false

    init(_ physicsBody: SKPhysicsBody) {
        self.physicsBody = physicsBody
    }

    var body: some View {
        VStack {
            Toggle(isOn: $affectedByGravity) {
                Text("affectedByGravity")
            }
            .toggleStyle(.checkbox)

            Toggle(isOn: $allowsRotation) {
                Text("allowsRotation")
            }
            .toggleStyle(.checkbox)

            Toggle(isOn: $isDynamic) {
                Text("isDynamic")
            }
            .toggleStyle(.checkbox)
        }
    }
}
