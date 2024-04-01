import SwiftUI

struct QueroModel {
    static let images: [Image] = [
        Image("quero0"),
        Image("quero1")
    ]
    
    static let largeSize = CGSize(width: formatSize(value: 109, with: .width), height: formatSize(value: 120, with: .height))
    static let smallSize = CGSize(width: formatSize(value: 114, with: .width), height: formatSize(value: 56, with: .height))
    
    static let initialPosition = CGPoint(x: -(UIScreen.main.bounds.width), y: UIScreen.main.bounds.height / 2)
    static let finalPosition = CGPoint(x: UIScreen.main.bounds.width + formatSize(value: 100, with: .width), y: initialPosition.y - formatSize(value: 200, with: .height))
}

