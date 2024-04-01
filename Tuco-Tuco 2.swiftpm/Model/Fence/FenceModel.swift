import SwiftUI

struct FenceModel {    
    static let draggableFencesPositions: [CGPoint] = [
        CGPoint(x: UIScreen.main.bounds.midX, y: formatSize(value: 700, with: .height)),
        CGPoint(x: UIScreen.main.bounds.midX + draggableFenceWidth + formatSize(value: 20, with: .width), y: formatSize(value: 700, with: .height))
    ]
    static let draggableFenceWidth = formatSize(value: 150, with: .width)
    
    
    static let fencesPositions: [CGPoint] = [
        CGPoint(x: formatSize(value: 200, with: .width), y: formatSize(value: 450, with: .height)),
        CGPoint(x: formatSize(value: 420, with: .width), y: formatSize(value: 350, with: .height))
    ]
    static let fencesWidths: [CGFloat] = [
        formatSize(value: 300, with: .width),
        formatSize(value: 110, with: .width)
    ]
    
    
    static let rangeX: ClosedRange<CGFloat> = -(draggableFenceWidth / 2)...formatSize(value: 550, with: .width)
    static let rangeY: ClosedRange<CGFloat> = formatSize(value: 165, with: .height)...formatSize(value: 550, with: .height)
}

