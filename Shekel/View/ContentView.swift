// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ContentView: View {
    @StateObject var playgroundState = PlaygroundState()
    @StateObject var gameController = GameController()

    var body: some View {
        GameControllerView()
            .environmentObject(gameController)
            .environmentObject(playgroundState)
            .onAppear() { gameController.postInit(playgroundState) }
    }
}
