// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SwiftUI

enum ClickToCreate: String, RawRepresentable, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case gremlin = "Gremlin", physics = "Physics", waypoint = "Waypoint"
}

enum PlaceablePhysics: String, RawRepresentable, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case field = "Field", joint = "Joint"
}

enum SelectionState {
    case many, none, one
}

class PlaygroundState: ObservableObject {
    @Published var cameraPosition: CGPoint = .zero
    @Published var cameraScale: CGFloat = 1
    @Published var clickToCreate: ClickToCreate = .gremlin
    @Published var placePhysics: PlaceablePhysics = .field
    @Published var mousePosition: CGPoint = .zero
    @Published var selectionState: SelectionState = .none
    @Published var viewSize: CGSize = .zero

    func setSelectionState(_ selectedEntities: Set<GameEntity>?) {
        let count = selectedEntities?.count ?? 0
        switch count {
        case 0: selectionState = .none
        case 1: selectionState = .one
        default: selectionState = .many
        }
    }
}
