// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class GameController: ObservableObject {
    let gameScene: GameScene
    let gameSettings: GameSettings

    var entities = Set<GameEntity>()

    init(gameSettings: GameSettings) {
        let selectionMarquee = SelectionMarquee(gameSettings)
        let gameScene = GameScene(selectionMarquee)

        self.gameSettings = gameSettings
        self.gameScene = gameScene
        self.gameScene.gameController = self
    }

    func click(_ clickDispatch: ClickDispatch) {
        if let entity = clickDispatch.entity {
            // Clicked on an entity; do selection stuff
            if !clickDispatch.shift {
                deselectAll()
            }

            select(entity)
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

    func moveSelected(_ dragDispatch: DragDispatch) {
        let delta = dragDispatch.entity!.dragAnchor! - dragDispatch.location

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

    func select(_ entity: GameEntity) {
        entity.halo?.select()
    }

    func setDragAnchorsForSelected() {
        getSelected().forEach { entity in
            entity.dragAnchor = entity.position
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
