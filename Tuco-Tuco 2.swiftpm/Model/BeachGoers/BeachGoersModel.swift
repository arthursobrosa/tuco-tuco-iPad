import SwiftUI

struct BeachGoersModel {
    static var images: [Image] = {
        var images: [Image] = []
        
        for i in 0...8 {
            let image = Image("beachGoers" + "\(i)")
            images.append(image)
        }
        
        return images
    }()
}

