import SwiftUI

struct ThrowSandModel {
    static let images: [Image] = [
        Image("throwSand0"),
        Image("throwSand1")
    ]
    
    static let initialPosition = CGPoint(x: formatSize(value: 780, with: .width), y: formatSize(value: 620, with: .height))
    static let finalPosition = CGPoint(x: initialPosition.x - formatSize(value: 300, with: .width), y: initialPosition.y - formatSize(value: 80, with: .height))
}

