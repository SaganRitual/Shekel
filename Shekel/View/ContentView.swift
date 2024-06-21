// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ContentView: View {
    @StateObject var playgroundState: PlaygroundState
    @StateObject var gameController: GameController

    init() {
        _playgroundState = StateObject(wrappedValue: PlaygroundState())
        _gameController = StateObject(wrappedValue: GameController(playgroundState: _playgroundState))
    }

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
