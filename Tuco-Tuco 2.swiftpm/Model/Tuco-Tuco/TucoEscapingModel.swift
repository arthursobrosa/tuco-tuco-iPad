import SwiftUI

struct TucoEscapingModel {
    static var images: [Image] = {
        var images: [Image] = []
        
        for i in 0...13 {
            let image = Image("tucoEscaping" + "\(i)")
            images.append(image)
        }
        
        return images
    }()
}

