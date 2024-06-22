// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct SpaceActionsTabView: View {
    @State private var showActionControls = false
    @State private var duration: Double = 5.0 // Default duration

    var body: some View {
        VStack {
            if showActionControls {
                Slider(value: $duration, in: 1...10, step: 0.5)
                    .padding()

                HStack {
                    Button("Click Here When Finished") {
                        // 1. Save the changes made to the entity as actions.
                        // 2. Add the new actions to the entity's action queue.
                        // 3. Update the scroll view with representations of the actions.
                        // 4. Reset the sprite and selection handle to their original states.
                        // 5. Show the "Click Here to Start" button again.
                        showActionControls = false
                    }

                    Button("Cancel") {
                        // 1. Cancel the operation.
                        // 2. Restore the original state of the Playground.
                        // 3. Show the "Click Here to Start" button again.
                        showActionControls = false
                    }
                }
            } else {
                Button("Click Here To Start") {
                    showActionControls = true
                    // (In your actual app, you'd also change the selection handle here)
                }
            }
        }
    }
}
