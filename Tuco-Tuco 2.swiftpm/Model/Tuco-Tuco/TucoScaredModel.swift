import SwiftUI

struct TucoScaredModel {
    static var images: [Image] = {
        var images: [Image] = []
        
        for i in 0...3 {
            let image = Image("tucoScared" + "\(i)")
            images.append(image)
        }
        
        return images
    }()
    
    static var widths: [CGFloat] = [
        formatSize(value: 80, with: .width),
        formatSize(value: 120, with: .width),
        formatSize(value: 100, with: .width),
        formatSize(value: 80, with: .width)
    ]
    
    static var positions: [CGPoint] = [
        CGPoint(x: formatSize(value: 260, with: .width), y: formatSize(value: 340, with: .height)),
        CGPoint(x: formatSize(value: 260, with: .width), y: formatSize(value: 340, with: .height)),
        CGPoint(x: formatSize(value: 270, with: .width), y: formatSize(value: 333, with: .height)),
        CGPoint(x: formatSize(value: 260, with: .width), y: formatSize(value: 333, with: .height))
    ]
}

