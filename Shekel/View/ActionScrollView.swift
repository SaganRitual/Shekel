// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ActionScrollView: View {
    @EnvironmentObject var playgroundState: PlaygroundState

    func createActionView(for container: ActionTokenContainer) -> any View {
        switch container.token {
        case let moveToken as MoveActionToken:
            return MoveActionTokenView(duration: moveToken.duration, targetPosition: moveToken.targetPosition)

        case let rotateToken as RotateActionToken:
            return RotationActionTokenView(duration: rotateToken.duration, targetRotation: rotateToken.targetRotation)

        case let scaleToken as ScaleActionToken:
            return ScaleActionTokenView(duration: scaleToken.duration, targetScale: scaleToken.targetScale)

        default:
            fatalError()
        }
    }

    var body: some View {
        Group {
            if playgroundState.activeActionTokens.isEmpty {
                Text("No actions assigned to this entity")
                    .padding()
            } else {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(playgroundState.activeActionTokens) { container in
                            AnyView(createActionView(for: container))
                        }
                    }
                }
                .padding()
            }
        }
        .background(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15), style: .circular).fill(Color(.controlBackgroundColor)))
    }
}
