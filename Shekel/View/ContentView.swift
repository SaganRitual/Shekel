// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ContentView: View {
    @StateObject var playgroundState = PlaygroundState()
    @EnvironmentObject var gameController: GameController

    var body: some View {
        HStack {
            SpriteKitView()
                .padding()
            PlaygroundStateView()
                .frame(width: 400)
        }
        .padding()
        .environmentObject(GameController(playgroundState: playgroundState))
    }
}
