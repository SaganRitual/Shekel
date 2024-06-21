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

struct DashboardView: View {
    var body: some View {
        VStack(spacing: 20) {
            PlaygroundStateView()
            Spacer()
            CommandsView()
            Spacer()
            ToolsView()
        }
        .padding()
        .frame(width: 400)
    }
}
