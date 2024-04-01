import SwiftUI

struct TucoDiggingModel {
    static var images: [Image] = {
        var images: [Image] = []
        
        for i in 0...10 {
            let image = Image("tucoDigging" + "\(i)")
            images.append(image)
        }
        
        return images
    }()
    
    static let width = formatSize(value: 300, with: .width)
    static let position = CGPoint(x: formatSize(value: 765, with: .width), y: formatSize(value: 620, with: .height))
}

