// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class Gremlin: GameEntity {
    private let halo_: SelectionHalo
    override var halo: SelectionHalo? { halo_ }

    private let view_: GameEntityView
    override var view: GameEntityView? { view_ }

    init(halo halo_: SelectionHalo, view view_: GameEntityView) {
        self.halo_ = halo_
        self.view_ = view_
    }

    static func make(at position: CGPoint) -> Gremlin {
        let halo = SelectionHaloRS.make()
        let view = GremlinView()
        let gremlin = Gremlin(halo: halo, view: view)

        halo.sceneNode.setOwnerEntity(gremlin)
        view.sceneNode.setOwnerEntity(gremlin)

        halo.subhandles.values.forEach { sh in
            sh.sceneNode.setOwnerEntity(gremlin)
        }

        gremlin.position = position

        return gremlin
    }
}
