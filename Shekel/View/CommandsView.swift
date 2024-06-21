// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct CommandsView: View {
    @EnvironmentObject var gameController: GameController

    @State private var clickToCreate: ClickToCreate = .gremlin
    @State private var gremlinSpriteName: String = "cyclops"
    @State private var physicsEntity: PlaceablePhysics = .joint

    let gremlinSpriteNames = ["cyclops"]

    var body: some View {
        VStack {
            Text("Commands")
                .underline()

            VStack(alignment: .leading) {
                Picker("Create on click", selection: $clickToCreate) {
                    ForEach(ClickToCreate.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.radioGroup)
            }
            .padding()

            switch clickToCreate {
            case .gremlin:
                Picker("Sprite", selection: $gremlinSpriteName) {
                    ForEach(gremlinSpriteNames, id: \.self) { name in
                        HStack {
                            Image(name).imageScale(.small)
                            Text(name)
                        }
                    }
                }
                .pickerStyle(.menu)

            case .physics:
                Picker("Physics", selection: $physicsEntity) {
                    ForEach(PlaceablePhysics.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.menu)

            case .waypoint:
                Text("Click in the scene to place Waypoints")
            }

        }
    }
}
