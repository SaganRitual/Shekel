// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SwiftUI

struct SidebarView: View {
    @EnvironmentObject var gameController: GameController

    var body: some View {
        VStack {
            Text("Mouse Position: \(gameController.gameSettings.mousePosition)")
            Spacer()
        }
    }
}
