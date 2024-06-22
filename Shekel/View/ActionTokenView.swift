// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

protocol ActionViewProtocol: View {
    var duration: Double { get set }
}

struct MoveActionView: View, ActionViewProtocol {
    @Binding var duration: Double

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ScaleActionView: View, ActionViewProtocol {
    @Binding var duration: Double

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
