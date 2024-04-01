import SwiftUI

struct GrassModel {
    static var widths: [CGFloat] = {
        var widths: [CGFloat] = []
        
        for i in 0...9 {
            let value: CGFloat = CGFloat(20 * i)
            let width = formatSize(value: 50 + value, with: .width)
            
            widths.append(width)
        }
        
        return widths
    }()
    
    static let positions: [CGPoint] = [
        CGPoint(x: UIScreen.main.bounds.midX - formatSize(value: 450, with: .width), y: UIScreen.main.bounds.midY - formatSize(value: 250, with: .height)),
        CGPoint(x: UIScreen.main.bounds.midX + formatSize(value: 450, with: .width), y: UIScreen.main.bounds.midY - formatSize(value: 100, with: .height)),
        CGPoint(x: UIScreen.main.bounds.midX + formatSize(value: 470, with: .width), y: UIScreen.main.bounds.midY + formatSize(value: 150, with: .height)),
        CGPoint(x: UIScreen.main.bounds.midX - formatSize(value: 530, with: .width), y: UIScreen.main.bounds.midY + formatSize(value: 300, with: .height))
    ]
    
    static let growthDelays: [Double] = [0, 0.5, 1.0, 1.5]
    
    static var numberOfGrass: Int = {
        return positions.count
    }()
    
    static let rangeX: ClosedRange<CGFloat> = formatSize(value: 260, with: .width)...formatSize(value: 520, with: .width)
    static let rangeY: ClosedRange<CGFloat> = formatSize(value: 360, with: .height)...formatSize(value: 490, with: .height)
}

