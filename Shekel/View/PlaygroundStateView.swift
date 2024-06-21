// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SwiftUI

struct PlaygroundStateView: View {
    @EnvironmentObject var gameController: GameController

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
//                Text("\(gameController.playgroundState)")
            }
            .padding(.bottom)

            Text("Mouse Position: \(gameController.playgroundState.mousePosition)")
            Spacer()
        }
        .monospaced()
    }
}
