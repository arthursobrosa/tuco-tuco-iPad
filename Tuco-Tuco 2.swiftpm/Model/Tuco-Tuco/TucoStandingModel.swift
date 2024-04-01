import SwiftUI

struct TucoStandingModel {
    static let images: [Image] = {
        var images: [Image] = []
        
        for i in 0...6 {
            let image = Image("tucoStanding" + "\(i)")
            images.append(image)
        }
        
        return images
    }()
    
    static let outsidePosition = CGPoint(x: UIScreen.main.bounds.midX + formatSize(value: 70, with: .width), y: UIScreen.main.bounds.midY)
    static let insidePosition = CGPoint(x: UIScreen.main.bounds.minX + formatSize(value: 230, with: .width), y: UIScreen.main.bounds.midY + formatSize(value: 230, with: .height))
}

struct TextAndSqueaks {
    static let outsideTexts: [String] = [
        "Hello!",
        "I'm Tuco, the tuco-tuco.",
        "I come from the beaches of southern Brazil and live here in the sand dunes.",
        "You seem nice! Would you like to come inside?"
    ]
    static let outsideSqueaks: [Int] = [1, 2, 4, 2]
    
    
    static let insideTexts: [String] = [
        "Welcome to my underground home!",
        "I live here because it's safer.",
        "To be honest, I don't really like it outside...",
        "And stay in these up to 70 meters long burrows.",
        "YES, 70 METERS LONG!",
        "Now can you help me eat something?"
    ]
    static let insideSqueaks: [Int] = [1, 2, 3, 3, 1, 4]
    
    
    static let shakingTexts: [String] = [
        "OH, NO! MY DEN IS FALLING APART!",
        "THERE'S SOMETHING GOING ON OUTSIDE!",
        "PLEASE HELP ME!"
    ]
    static let shakingSqueaks: [Int] = [2, 2, 1]
    
    
    static let beachGoersTexts: [String] = [
        "The beachgoers arrived and they're walking over my dune!",
        "Please do something to prevent that!"
    ]
    static let beachGoersSqueaks: [Int] = [3, 2]
    
    
    static let carOnBeachTexts: [String] = [
        "They're gone!",
        "Thanks for your help!",
        "People left, but look!",
        "There's a car coming over... Help me make it go away."
    ]
    static let carOnBeachSqueaks: [Int] = [1, 1, 2, 3]
    
    
    static let dogTexts: [String] = [
        "Great!",
        "Now people and cars are gone.",
        "There are other threats to us though, like domestic animals...",
        "Look! A dog is coming towards the dunes!"
    ]
    static let dogSqueaks: [Int] = [1, 2, 4, 2]
    
    
    static let lastTexts: [String] = [
        "Now I can say I'm feeling safer.",
        "But the struggle is real and raising awareness about wildlife conservation is essential!",
        "Anyways... Thank you so much for your time!"
    ]
    static let lastSqueaks: [Int] = [2, 5, 2]
}

