import SwiftUI

struct TucoWalkingInDenModel {
    static var images: [Image] = {
        var images: [Image] = []
        
        for i in 0...11 {
            let image = Image("tucoWalkingInDen" + "\(i)")
            images.append(image)
        }
        
        return images
    }()
}

