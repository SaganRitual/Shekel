// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

struct DragDispatch {
    enum Phase { case begin, `continue`, end }

    let control: Bool
    let subhandleDirection: SelectionHaloRS.Directions?
    let entity: GameEntity?
    let location: CGPoint
    let phase: Phase
    let shift: Bool

    static func begin(_ entity: GameEntity?, _ mouseDispatch: MouseDispatch) -> DragDispatch {
        DragDispatch(.begin, entity, nil, mouseDispatch)
    }

    static func `continue`(_ entity: GameEntity?, _ mouseDispatch: MouseDispatch) -> DragDispatch {
        DragDispatch(.continue, entity, nil, mouseDispatch)
    }

    static func end(_ entity: GameEntity?, _ mouseDispatch: MouseDispatch) -> DragDispatch {
        DragDispatch(.end, entity, nil, mouseDispatch)
    }

    static func beginRS(_ entity: GameEntity?, _ subhandleDirection: SelectionHaloRS.Directions, _ mouseDispatch: MouseDispatch) -> DragDispatch {
        DragDispatch(.begin, entity, subhandleDirection, mouseDispatch)
    }

    static func continueRS(_ entity: GameEntity?, _ subhandleDirection: SelectionHaloRS.Directions, _ mouseDispatch: MouseDispatch) -> DragDispatch {
        DragDispatch(.continue, entity, subhandleDirection, mouseDispatch)
    }

    static func endRS(_ entity: GameEntity?, _ subhandleDirection: SelectionHaloRS.Directions, _ mouseDispatch: MouseDispatch) -> DragDispatch {
        DragDispatch(.end, entity, subhandleDirection, mouseDispatch)
    }

    private init(_ phase: Phase, _ entity: GameEntity?, _ subhandleDirection: SelectionHaloRS.Directions?, _ mouseDispatch: MouseDispatch) {
        self.control = mouseDispatch.control
        self.subhandleDirection = subhandleDirection
        self.entity = entity
        self.location = mouseDispatch.location
        self.phase = phase
        self.shift = mouseDispatch.shift
    }
}
