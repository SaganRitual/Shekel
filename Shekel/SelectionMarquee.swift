// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import Foundation
import SpriteKit

enum SpriteWorld {
    enum Directions: Int, CaseIterable { case n = 0, e = 1, s = 2, w = 3 }
}

class SelectionMarquee {
    // Setup anchor points for each side of the marquee to make
    // positioning the sprites super-easy
    let anchorPoints: [SpriteWorld.Directions: CGPoint] = [
        .n: CGPoint(x: 0, y: 0.5),
        .e: CGPoint(x: 0.5, y: 0),
        .s: CGPoint(x: 1, y: 0.5),
        .w: CGPoint(x: 0.5, y: 1)
    ]

    let gameSettings: GameSettings
    let marqueeRootNode = SKNode()

    var borderSprites = [SpriteWorld.Directions: SKSpriteNode]()

    var dragAnchor = CGPoint.zero

    init(_ gameSettings: GameSettings) {
        self.gameSettings = gameSettings

        SpriteWorld.Directions.allCases.forEach { direction in
            let sprite = SKSpriteNode(imageNamed: "pixel_1x1")
            sprite.name = "selectionMarqueeSprite_\(direction)"

            sprite.alpha = 0.7
            sprite.colorBlendFactor = 1
            sprite.color = .yellow
            sprite.isHidden = false
            sprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            sprite.size = CGSize(width: 1, height: 1)

            sprite.anchorPoint = anchorPoints[direction]!

            borderSprites[direction] = sprite

            marqueeRootNode.addChild(sprite)
        }

        marqueeRootNode.isHidden = true
    }

    func drag(_ dragDispatch: DragDispatch) {
        switch dragDispatch.phase {
        case .begin:
            dragAnchor = dragDispatch.location
        case .continue:
            draw(from: dragAnchor, to: dragDispatch.location)
        case .end:
            hide()
        }
    }
}

private extension SelectionMarquee {

    func show() { marqueeRootNode.isHidden = false }
    func hide() { marqueeRootNode.isHidden = true }

    func draw(from startVertex: CGPoint, to endVertex: CGPoint) {
        if startVertex == endVertex {
            // In case the user is futzing with the mouse and causes
            // the box size to go back to zero
            hide()
            return
        }

        // If the user begins dragging and moves the mouse up and to the left, this box size
        // will have negative width and height. Fortunately, that's exactly what we need for
        // scaling the width and height of the rubber band sprites to track perfectly with the mouse
        let boxSize = CGSize(width: endVertex.x - startVertex.x, height: endVertex.y - startVertex.y)

        borderSprites[.n]!.position = endVertex
        borderSprites[.w]!.position = endVertex

        borderSprites[.e]!.position = startVertex
        borderSprites[.s]!.position = startVertex

        // The negative camera scale is an artifact of the way we convert
        // the start/end vertices from the view, I think. Come back to it
        // and make more sense of it at some point
        let hScale = CGSize(width: boxSize.width, height: 2) * -gameSettings.cameraScale

        borderSprites[.n]!.scale(to: hScale)
        borderSprites[.s]!.scale(to: hScale)

        let vScale = CGSize(width: 2, height: boxSize.height) * gameSettings.cameraScale

        borderSprites[.e]!.scale(to: vScale)
        borderSprites[.w]!.scale(to: vScale)

        show()
    }

}
