// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct GameControllerView: View {
    @EnvironmentObject var gameController: GameController

    var body: some View {
        HStack {
            SpriteKitView()
            DashboardView()
                .frame(width: 400)
        }
        .padding()
        .environmentObject(gameController)
    }
}
