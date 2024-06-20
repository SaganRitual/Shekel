// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

extension GameScene {

    override func mouseDown(with event: NSEvent) {
//        let mouseDispatch = MouseDispatch(from: event, scene: self)
        mouseState = .mouseDown
    }

    override func mouseDragged(with event: NSEvent) {
        let mouseDispatch = MouseDispatch(from: event, scene: self)
        gameController.gameSettings.mousePosition = mouseDispatch.location

        if mouseState == .idle {
            dragBegin(mouseDispatch)
        }

        let dragDispatch = DragDispatch.continue(hotDragTarget, mouseDispatch)

        switch mouseState {
        case .dragBackground:
            selectionMarquee.drag(dragDispatch)
        case .dragHandle:
            gameController.drag(dragDispatch)
        default:
            assert(false, "Nine out of ten dentists have said this cannot occur")
        }
    }

    override func mouseMoved(with event: NSEvent) {
        let mouseDispatch = MouseDispatch(from: event, scene: self)
        gameController.gameSettings.mousePosition = mouseDispatch.location
    }

    override func mouseUp(with event: NSEvent) {
        let mouseDispatch = MouseDispatch(from: event, scene: self)

        switch mouseState {
        case .dragBackground:
            let dragDispatch = DragDispatch.end(nil, mouseDispatch)
            selectionMarquee.drag(dragDispatch)
        case .dragHandle:
            break
        case .mouseDown:
            guard let topNode = nodes(at: mouseDispatch.location).first(where: { $0 !== entitiesNode }) else {
                // Nothing at the click point; create an entity
                let clickDispatch = ClickDispatch.click(nil, mouseDispatch)
                gameController.click(clickDispatch)
                return
            }

            guard let entity = topNode.getOwnerEntity() else {
                fatalError("Clicked a node that doesn't have an owner entity?")
            }

            let clickDispatch = ClickDispatch.click(entity, mouseDispatch)
            gameController.click(clickDispatch)

        case .idle:
            fatalError("Reputable scholars say this can't happen")
        }

        mouseState = .idle
    }
    
}

private extension GameScene {

    // Remember: the selection controller needs to know about drag-entity-begin -- because that might
    // require the entity to be selected -- and drag-background-end -- because that's how you select
    // things with a selection marquee: by letting go of the mouse button

    func dragBegin(_ mouseDispatch: MouseDispatch) {
        guard let topNode = nodes(at: mouseDispatch.location).first else {
            selectionMarquee.drag(DragDispatch.begin(nil, mouseDispatch))
            mouseState = .dragBackground
            return
        }

        guard let entity = topNode.getOwnerEntity() else {
            assert(false, "Every visible node should be owned by an entity")
            return
        }

        let dragDispatch = DragDispatch.begin(entity, mouseDispatch)

        hotDragTarget = entity
        gameController.drag(dragDispatch)
        mouseState = .dragHandle
    }

    func makeRectangle(vertexA: CGPoint, vertexB: CGPoint) -> CGRect {
        let LL = CGPoint(x: min(vertexA.x, vertexB.x), y: min(vertexA.y, vertexB.y))
        let UR = CGPoint(x: max(vertexA.x, vertexB.x), y: max(vertexA.y, vertexB.y))

        let size = CGSize(width: UR.x - LL.x, height: UR.y - LL.y)

        return CGRect(origin: LL, size: size)
    }

}
