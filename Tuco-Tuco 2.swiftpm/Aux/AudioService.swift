import SwiftUI
import AVFoundation

enum Sound: String {
    case waves
    case queroBird
    case squeak
    case throwSand
    case eating
    case earthQuake
    case movingInTunnel
    case beachGoers
    case correct
    case engine
    case grow
    case bark
}

enum SoundError: Error {
    case URLNotFound
    case invalidURL
}

class AudioService: ObservableObject {
    private let soundCase: Sound
    
    init(soundCase: Sound) {
        self.soundCase = soundCase
    }
    
    public func getSound() throws -> AVAudioPlayer {
        guard let soundURL = Bundle.main.url(forResource: self.soundCase.rawValue, withExtension: "mp3") else {
            throw SoundError.URLNotFound
        }
        
        do {
            return try AVAudioPlayer(contentsOf: soundURL)
        } catch {
            throw SoundError.invalidURL
        }
    }
}

