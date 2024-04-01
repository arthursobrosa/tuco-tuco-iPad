import SwiftUI

struct SignModel {
    static let draggableSignWidth = formatSize(value: 150, with: .width)
    static let draggableSignOriginalPosition = CGPoint(x: UIScreen.main.bounds.midX, y: formatSize(value: 150, with: .height))
    
    static let rangeX = UIScreen.main.bounds.minX...UIScreen.main.bounds.maxX
    static let rangeY = formatSize(value: 350, with: .height)...UIScreen.main.bounds.maxY
}

