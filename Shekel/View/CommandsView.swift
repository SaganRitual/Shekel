// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct CommandsView: View {
    var body: some View {
        VStack {
            Text("Commands")
            Button(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/) {
                print("Hello, World!")
            }
        }
    }
}
