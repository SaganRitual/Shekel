// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

enum GremlinImageName: String, RawRepresentable {
    case cyclops
}

enum ActionType {
    enum Physics {
        case angularImpulse, force, impulse, torque
    }
    enum Space {
        case move, rotate, scale
    }
}

enum SelectionState {
    case many, none, one
}

struct DashboardView: View {
    @StateObject var playgroundState: PlaygroundState

    var body: some View {
        VStack(spacing: 20) {
            PlaygroundStateView()
            CommandsView()
            ToolsView()
        }
        .padding()
        .frame(width: 400)
    }
}
