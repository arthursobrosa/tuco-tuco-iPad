import SwiftUI
import Combine
import AVFoundation

class AllFencesViewModel: ObservableObject {
    @Published var numberOfFences = 0
    @Published var showFirstFence = false
    @Published var showSecondFence = false
    
    @Published var arePeopleOverDune = true
    
    private var audioPlayer: AVAudioPlayer? = nil
    
    
    private var showFencePublisher: AnyCancellable?
    
    init() {
        setShowFence()
        setAudio()
    }
    
    private func setShowFence() {
        showFencePublisher = $numberOfFences
            .sink { [weak self] count in
                guard let self = self else { return }
                
                if count > 0 {
                    self.playAudio()
                }
                
                switch count {
                case 1:
                    self.showFirstFence = true
                case 2:
                    self.showSecondFence = true
                    self.arePeopleOverDune = false
                    self.showFencePublisher?.cancel()
                default:
                    break
                }
            }
    }
    
    private func setAudio() {
        do {
            audioPlayer = try AudioService(soundCase: .correct).getSound()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    private func playAudio() {
        print("playing audio")
        audioPlayer?.play()
    }
}

