import SwiftUI

struct CarModel {
    static let width = formatSize(value: 700, with: .width)
    
    static let initialPosition = CGPoint(
        x: UIScreen.main.bounds.maxX + formatSize(value: 350, with: .width),
        y: UIScreen.main.bounds.midY
    )
    static let finalPosition = CGPoint(
        x: formatSize(value: -350, with: .width),
        y: UIScreen.main.bounds.midY
    )
}

