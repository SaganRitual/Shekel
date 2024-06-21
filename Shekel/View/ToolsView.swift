// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ToolsView: View {
    @EnvironmentObject var gameController: GameController

    var body: some View {
        VStack {
            Text("Tools")
                .underline()

            switch gameController.playgroundState.selectionState {
            case .many:
                Text("Multiple items selected")
            case .none:
                Text("Nothing Selected")
            case .one:
                Text("Physics")
                    .underline()

                if let gremlin = gameController.getSelected().first {
                    if let pb = gremlin.physicsBody {
                        PhysicsBodyView(pb)
                    } else {
                        Button("Assign Physics Body") {
                            gameController.assignPhysicsBody(to: gremlin)
                        }
                    }
                } else {
                    Text("huh?")
                }
            }
        }
    }
}
