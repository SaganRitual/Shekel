// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

protocol ActionTokenProtocol {
    var duration: TimeInterval { get }
}

struct MoveActionToken: ActionTokenProtocol {
    let duration: TimeInterval
    let targetPosition: CGPoint
}

struct RotateActionToken: ActionTokenProtocol {
    let duration: TimeInterval
    let targetRotation: CGFloat
}

struct ScaleActionToken: ActionTokenProtocol {
    let duration: TimeInterval
    let targetScale: CGFloat
}

struct ForceActionToken: ActionTokenProtocol {
    let duration: TimeInterval
    let focus: CGPoint
    let force: CGVector
}

struct TorqueActionToken: ActionTokenProtocol {
    let duration: TimeInterval
    let torque: CGFloat
}

struct ImpulseActionToken: ActionTokenProtocol {
    let duration: TimeInterval
    let focus: CGPoint
    let impulse: CGVector
}

struct AngularImpulseActionToken: ActionTokenProtocol {
    let duration: TimeInterval
    let angularImpulse: CGFloat
}
