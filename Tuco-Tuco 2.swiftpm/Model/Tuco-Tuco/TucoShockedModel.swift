import SwiftUI

struct TucoShockedModel {
    static var images: [Image] = {
        var images: [Image] = []
        
        for i in 0...3 {
            let image = Image("tucoShocked" + "\(i)")
            images.append(image)
        }
        
        return images
    }()
}

