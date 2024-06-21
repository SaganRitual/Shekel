// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SwiftUI

struct PlaygroundStateView: View {
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var playgroundState: PlaygroundState

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("SpriteKit Playground")
                Spacer()
            }
            .padding(.bottom)

            HStack {
                Spacer()
                Text("Size").underline()
                Spacer()
            }
            .padding(.bottom)

            HStack {
                Text("View/Scene")
                Spacer()
                Text("\(playgroundState.viewSize)")
            }
            .padding(.bottom)

            HStack {
                Text("Mouse Position")
                Spacer()
                Text(Utility.mousePositionString(playgroundState.mousePosition))
            }
        }
        .monospaced()
    }
}
