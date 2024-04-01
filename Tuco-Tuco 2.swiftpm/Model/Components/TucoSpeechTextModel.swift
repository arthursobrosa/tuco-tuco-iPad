import SwiftUI

struct TucoSpeechTextModel {
    static let outsideSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: formatSize(value: 300, with: .height))
    static let insideSize: CGSize = CGSize(width: UIScreen.main.bounds.width / 1.5, height: formatSize(value: 300, with: .height))
    
    static let outsideTextColor = Color.white
    static let insideTextColor = Color.black
    
    static let outsideFrameColor = Color.cyan
    static let insideFrameColor = Color.white
    
    static let outsideFrameCornerRadius = 0.0
    static let insideFrameCornerRadius = 20.0
    
    static let outsidePosition = CGPoint(x: UIScreen.main.bounds.width / 2, y: formatSize(value: 670, with: .height))
    static let insidePosition = CGPoint(x: UIScreen.main.bounds.width / 2 + formatSize(value: 180, with: .width), y: formatSize(value: 600, with: .height))
}

