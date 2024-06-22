// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct SpaceActionsTabView: View {
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var playgroundState: PlaygroundState

    @State private var duration: CGFloat = 0.5

    var body: some View {
        VStack {
            if playgroundState.assignSpaceActions {
                VStack {
                    Text("Duration " + String(format: "%.1f", duration))
                    HStack {
                        Text("0.5")
                        Slider(value: $duration, in: (0.5)...(10), step: 0.5)
                            .padding()
                        Text("10")
                    }
                }
                .padding([.leading, .trailing])

                HStack {
                    Button("Create Action(s)") {
                        // 1. Save the changes made to the entity as actions.
                        // 2. Add the new actions to the entity's action queue.
                        // 3. Update the scroll view with representations of the actions.
                        // 4. Reset the sprite and selection handle to their original states.
                        // 5. Show the "Click Here to Start" button again.
                        gameController.commitActions(duration: duration)
                    }

                    Button("Cancel") {
                        // 1. Cancel the operation.
                        // 2. Restore the original state of the Playground.
                        // 3. Show the "Click Here to Start" button again.
                        gameController.cancelAssignActionsMode()
                    }
                }
            } else {
                Button("Start") {
                    gameController.startActionsMode()
                }
            }
        }
    }
}
