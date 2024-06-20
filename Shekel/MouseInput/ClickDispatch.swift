// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

struct ClickDispatch {
    let control: Bool
    let entity: GameEntity?
    let location: CGPoint
    let shift: Bool

    static func click(_ entity: GameEntity?, _ mouseDispatch: MouseDispatch) -> ClickDispatch {
        ClickDispatch(entity, mouseDispatch)
    }

    private init(_ entity: GameEntity?, _ mouseDispatch: MouseDispatch) {
        self.control = mouseDispatch.control
        self.shift = mouseDispatch.shift
        self.entity = entity
        self.location = mouseDispatch.location
    }
}
