// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsActionsTabView: View {
    enum PhysicsActionType: String, CaseIterable, Identifiable { // Add Identifiable to use with Picker
        case force, impulse, torque, angularImpulse
        var id: Self { self } // Implementation for Identifiable
    }

    @State private var selectedType = PhysicsActionType.force
    @State private var duration: Double = 5.0
    @State private var forceVector: CGPoint = .zero // For force/impulse trackpad
    @State private var torqueValue: Double = 0.0 // For torque/angularImpulse slider

    var body: some View {
        VStack {
            Picker("Physics Action Type", selection: $selectedType) {
                ForEach(PhysicsActionType.allCases) { type in
                    Text(type.rawValue.capitalized).tag(type)
                }
            }
            .pickerStyle(.segmented) // Use segmented control style for radio buttons

            if selectedType == .force || selectedType == .impulse {
                EmptyView()
//                Trackpad(vector: $forceVector) // Your custom Trackpad view
            } else {
                Slider(value: $torqueValue, in: -10...10) // Slider for torque/angularImpulse
            }

            Slider(value: $duration, in: 1...10, step: 0.5)
                .padding()

            Button("Create Physics Action") {
                // 1. Create the appropriate Physics Action (force, impulse, torque, or angular impulse)
                // 2. Use forceVector or torqueValue, and duration as needed
                // 3. Attach the action to the entity
            }
        }
        .padding()
    }
}
