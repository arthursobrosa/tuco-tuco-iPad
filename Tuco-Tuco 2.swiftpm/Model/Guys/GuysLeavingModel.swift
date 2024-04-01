import SwiftUI

struct GuysLeavingModel {
    static let firstGuyInitialPosition = CGPoint(x: formatSize(value: 60, with: .width), y: formatSize(value: 305, with: .height))
    static let firstGuyFinalPosition = CGPoint(
        x: formatSize(value: -100, with: .width),
        y: firstGuyInitialPosition.y + formatSize(value: 100, with: .height)
    )
    
    static let secondGuyInitialPosition = CGPoint(x: formatSize(value: 520, with: .width), y: formatSize(value: 315, with: .height))
    static let secondGuyFinalPosition = CGPoint(
        x: UIScreen.main.bounds.maxX + formatSize(value: 100, with: .width),
        y: secondGuyInitialPosition.y + formatSize(value: 150, with: .height)
    )
    
    static let guysHeight = formatSize(value: 320, with: .height)
    
    static let firstGuyAnimationTime = 1.0
    static let secondGuyAnimationTime = 3.0
}

