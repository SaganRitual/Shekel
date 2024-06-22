// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ActionsTabView: View {
    var body: some View {
        TabView {
            SpaceActionsTabView()
                .tabItem {
                    Label("Space", systemImage: "globe")
                }

            PhysicsActionsTabView()
                .tabItem {
                    Label("Physics", systemImage: "atom")
                }
        }
    }
}
