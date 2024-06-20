// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

struct DragDispatch {
    enum Phase { case begin, `continue`, end }

    let control: Bool
    let entity: GameEntity?
    let location: CGPoint
    let phase: Phase
    let shift: Bool

    static func begin(_ entity: GameEntity?, _ mouseDispatch: MouseDispatch) -> DragDispatch {
        DragDispatch(.begin, entity, mouseDispatch)
    }

    static func `continue`(_ entity: GameEntity?, _ mouseDispatch: MouseDispatch) -> DragDispatch {
        DragDispatch(.continue, entity, mouseDispatch)
    }

    static func end(_ entity: GameEntity?, _ mouseDispatch: MouseDispatch) -> DragDispatch {
        DragDispatch(.end, entity, mouseDispatch)
    }

    private init(_ phase: Phase, _ entity: GameEntity?, _ mouseDispatch: MouseDispatch) {
        self.control = mouseDispatch.control
        self.entity = entity
        self.location = mouseDispatch.location
        self.phase = phase
        self.shift = mouseDispatch.shift
    }
}
