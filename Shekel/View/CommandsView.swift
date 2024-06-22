// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct CommandsView: View {
    @EnvironmentObject var gameController: GameController

    @State private var clickToCreate: ClickToCreate = .gremlin
    @State private var gremlinSpriteName: String = "cyclops"
    @State private var physicsEntity: PlaceablePhysics = .joint

    let gremlinSpriteNames = ["cyclops"]

    var body: some View {
        VStack(alignment: .center) {
            Text("Commands")
                .underline()
                .padding(.bottom)

            Text("Create on Click:")
                .padding(.bottom)

            HStack(alignment: .top) {
                Picker("", selection: $clickToCreate) {
                    ForEach(ClickToCreate.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.radioGroup)
                .frame(minWidth: 100)

                Spacer()

                VStack(alignment: .leading) {
                    switch clickToCreate {
                    case .gremlin:
                        Picker("", selection: $gremlinSpriteName) {
                            ForEach(gremlinSpriteNames, id: \.self) { name in
                                HStack {
                                    Image(name).imageScale(.small)
                                    Text(name)
                                }
                            }
                        }
                        .pickerStyle(.menu)

                    case .physics:
                        Picker("", selection: $physicsEntity) {
                            ForEach(PlaceablePhysics.allCases) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .pickerStyle(.menu)

                    case .waypoint:
                        Text("Click in the scene to place Waypoints")
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(minHeight: 100)
        }
    }
}
