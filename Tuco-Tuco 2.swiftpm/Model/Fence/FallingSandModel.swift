import SwiftUI

struct FallingSandModel {
    static var images: [Image] = {
        var images: [Image] = []
        
        for i in 0...9 {
            let image = Image("fallingSand" + "\(i)")
            images.append(image)
        }
        
        return images
    }()
    
    static let originalPosition = CGPoint(x: formatSize(value: 180, with: .width), y: formatSize(value: -20, with: .height))
}

