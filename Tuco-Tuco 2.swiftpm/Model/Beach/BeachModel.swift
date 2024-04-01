import SwiftUI

struct BeachModel {
    static let initialPosition = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
    static let finalPosition = CGPoint(x: formatSize(value: -3000, with: .width), y: formatSize(value: -1780, with: .height))
}

