import SwiftUI

struct TucoEnteringHoleModel {
    static let initialPosition = CGPoint(x: formatSize(value: 765, with: .width), y: formatSize(value: 620, with: .height))
    
    static func nextPosition(_ lastPosition: CGPoint) -> CGPoint {
        return CGPoint(x: lastPosition.x + formatSize(value: 50, with: .width), y: lastPosition.y)
    }
}

