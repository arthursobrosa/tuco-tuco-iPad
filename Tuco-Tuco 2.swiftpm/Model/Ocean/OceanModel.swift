import SwiftUI

struct OceanModel {
    static var images: [Image] = {
        var images: [Image] = []
        
        for i in 0...5 {
            let image = Image("ocean" + "\(i)")
            images.append(image)
        }
        
        return images
    }()
}

