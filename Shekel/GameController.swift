// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class GameController: ObservableObject {
    var gameScene: GameScene!
    let playgroundState: PlaygroundState
    let selectionMarquee: SelectionMarquee

    var entities = Set<GameEntity>()

    init(playgroundState: PlaygroundState) {
        self.selectionMarquee = SelectionMarquee(playgroundState)
        self.playgroundState = playgroundState
    }

    func click(_ clickDispatch: ClickDispatch) {
        if let entity = clickDispatch.entity {
            // Clicked on an entity; do selection stuff
            if clickDispatch.shift {
                toggleSelect(entity)
            } else {
                deselectAll()
                select(entity)
            }

            return
        }

        let gremlin = newGremlin(at: clickDispatch.location)
        entities.insert(gremlin)

        deselectAll()
        select(gremlin)
    }

    func deselect(_ entity: GameEntity) {
        entity.halo?.deselect()
    }

    func deselectAll() {
        entities.forEach { deselect($0) }
    }

    func drag(_ dragDispatch: DragDispatch) {
        switch dragDispatch.phase {
        case .begin:
            let entity = dragDispatch.entity!
            let halo = entity.halo!

            if !halo.isSelected {
                halo.select()
            }

            setDragAnchorsForSelected()

        case .continue:
            moveSelected(dragDispatch)

        case .end:
            break
        }
    }

    func handleMarqueeSelection(_ entities: Set<GameEntity>, _ dragDispatch: DragDispatch) {
        if dragDispatch.shift {
            entities.forEach { toggleSelect($0) }
        } else {
            deselectAll()
            entities.forEach { select($0) }
        }
    }

    func makeGameScene(_ size: CGSize) -> GameScene {
        let gameScene = GameScene(size, selectionMarquee)
        gameScene.gameController = self
        gameScene.scaleMode = .resizeFill
        gameScene.isUserInteractionEnabled = true
        self.gameScene = gameScene
        return gameScene
    }

    func moveSelected(_ dragDispatch: DragDispatch) {
        let delta = dragDispatch.location - dragDispatch.entity!.dragAnchor!

        getSelected().forEach { entity in
            entity.position = entity.dragAnchor! + delta
        }
    }

    func newGremlin(at position: CGPoint) -> Gremlin {
        let gremlin = Gremlin.make(at: position)

        gameScene.entitiesNode.addChild(gremlin.view!.sceneNode)
        gameScene.entitiesNode.addChild(gremlin.halo!.sceneNode)

        entities.insert(gremlin)

        return gremlin
    }

    func roscaleSelected(_ dragDispatch: DragDispatch) {
        let endVertex = dragDispatch.location
        let dragAnchor = dragDispatch.entity!.dragAnchor!

        let delta = endVertex - dragAnchor
        let distance = delta.magnitude
        let scale = max(1, distance / SelectionHaloRS.radius)
        var rotation = atan2(delta.y, delta.x)

        switch dragDispatch.subhandleDirection! {
        case .n: rotation -= .pi / 2
        case .e: rotation += 0
        case .s: rotation += .pi / 2
        case .w: rotation += .pi
        }

        let rDelta = rotation - dragDispatch.entity!.rotationAnchor!
        let sDelta = scale - dragDispatch.entity!.scaleAnchor!

        getSelected().forEach { entity in
            entity.rotation = entity.rotationAnchor! + rDelta
            entity.scale = entity.scaleAnchor! + sDelta
        }
    }

    func select(_ entity: GameEntity) {
        entity.halo?.select()
    }

    func setRoscaleAnchorsForSelected() {
        getSelected().forEach { entity in
            entity.rotationAnchor = entity.rotation
            entity.scaleAnchor = entity.scale
        }
    }

    func setDragAnchorsForSelected() {
        getSelected().forEach { entity in
            entity.dragAnchor = entity.position
        }
    }

    func subhandleDrag(_ dragDispatch: DragDispatch) {
        switch dragDispatch.phase {
        case .begin:
            let entity = dragDispatch.entity!

            entity.dragAnchor = entity.position
            setRoscaleAnchorsForSelected()

        case .continue:
            roscaleSelected(dragDispatch)

        case .end:
            break
        }

    }

    func toggleSelect(_ entity: GameEntity) {
        entity.halo?.toggleSelect()
    }
}

private extension GameController {

    func getSelected() -> Set<GameEntity> {
        getSelected(self.entities)
    }

    func getSelected(_ entities: Set<GameEntity>) -> Set<GameEntity> {
        let selected = entities.compactMap { entity in
            entity.halo!.isSelected ? entity : nil
        }

        return Set(selected)
    }

}
