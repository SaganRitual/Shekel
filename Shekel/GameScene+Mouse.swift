// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

extension GameScene {

    override func mouseDown(with event: NSEvent) {
        mouseState = .mouseDown
    }

    override func mouseDragged(with event: NSEvent) {
        let mouseDispatch = MouseDispatch(from: event, scene: self)
        playgroundState.mousePosition = mouseDispatch.location

        if case .mouseDown = mouseState {
            dragBegin(mouseDispatch)
        }

        let dragDispatch = DragDispatch.continue(hotDragTarget, mouseDispatch)

        switch mouseState {
        case .dragBackground:
            selectionMarquee.drag(dragDispatch)
        case .dragHandle:
            gameController.drag(dragDispatch)
        case .dragSubhandle:
            let rsDragDispatch = DragDispatch.continueRS(hotDragTarget, hotDragSubhandle!, mouseDispatch)
            gameController.subhandleDrag(rsDragDispatch)
        default:
            fatalError("Nine out of ten tech CEOs say this can't happen")
        }
    }

    override func mouseMoved(with event: NSEvent) {
        let mouseDispatch = MouseDispatch(from: event, scene: self)
        playgroundState.mousePosition = mouseDispatch.location
    }

    override func mouseUp(with event: NSEvent) {
        let mouseDispatch = MouseDispatch(from: event, scene: self)

        switch mouseState {
        case .dragBackground:
            let dragDispatch = DragDispatch.end(nil, mouseDispatch)
            selectionMarquee.drag(dragDispatch)

            let vertexA = selectionMarquee.dragAnchor
            let rectangle = makeRectangle(vertexA: vertexA, vertexB: dragDispatch.location)
            let enclosedNodes = getNodesInRectangle(rectangle)
            let enclosedEntities = Set(enclosedNodes.compactMap { $0.getOwnerEntity() })
            gameController.handleMarqueeSelection(enclosedEntities, dragDispatch)

        case .dragHandle:
            break

        case .dragSubhandle:
            break

        case .mouseDown:
            // Note that we're checking the nodes for owner entity. We shouldn't have to
            // do it, but sometimes nodes(at:) will include nodes we don't want,
            // such as the entities node, which has zero size and technically sits at the origin
            guard let topNode = getTopNode(at: mouseDispatch.location) else {
                // Nothing at the click point; create an entity
                let clickDispatch = ClickDispatch.click(nil, mouseDispatch)
                gameController.click(clickDispatch)
                return
            }

            guard let entity = topNode.getOwnerEntity() else {
                assert(false, "Got a node with no owner? See getTopNode()")
                return
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
        guard let topNode = getTopNode(at: mouseDispatch.location) else {
            selectionMarquee.drag(DragDispatch.begin(nil, mouseDispatch))
            mouseState = .dragBackground
            return
        }

        guard let entity = topNode.getOwnerEntity() else {
            assert(false, "Got a node with no owner? See getTopNode()")
            return
        }

        if let haloRS = entity.halo as? SelectionHaloRS {
            if let direction = haloRS.getSubhandleDirection(topNode) {
                let rsDragDispatch = DragDispatch.beginRS(entity, direction, mouseDispatch)

                hotDragTarget = entity
                hotDragSubhandle = direction
                gameController.subhandleDrag(rsDragDispatch)
                mouseState = .dragSubhandle
                return
            }
        }

        let dragDispatch = DragDispatch.begin(entity, mouseDispatch)

        hotDragTarget = entity
        gameController.drag(dragDispatch)
        mouseState = .dragHandle
    }

    func getNodesInRectangle(_ rectangle: CGRect) -> [SKNode] {
        return entitiesNode.children.compactMap { node in
            guard rectangle.contains(node.position) else {
                return nil
            }

            if node.getOwnerEntity() == nil {
                return nil
            }

            return node
        }
    }

    func getTopNode(at position: CGPoint) -> SKNode? {
        nodes(at: position).first(where: { $0.getOwnerEntity() != nil })
    }

    func makeRectangle(vertexA: CGPoint, vertexB: CGPoint) -> CGRect {
        let LL = CGPoint(x: min(vertexA.x, vertexB.x), y: min(vertexA.y, vertexB.y))
        let UR = CGPoint(x: max(vertexA.x, vertexB.x), y: max(vertexA.y, vertexB.y))

        let size = CGSize(width: UR.x - LL.x, height: UR.y - LL.y)

        return CGRect(origin: LL, size: size)
    }

}
