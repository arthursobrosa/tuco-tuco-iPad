import SwiftUI
import Combine
import AVFoundation

class ThrowSandViewModel: ObservableObject {
    @Published var count = 0
    @Published var currentImage = ThrowSandModel.images[0]
    @Published var frameOpacity = 1.0
    @Published var position = ThrowSandModel.initialPosition
    
    private var audioPlayer: AVAudioPlayer? = nil
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setTimer()
        setAudio()
        setActions()
    }
    
    private func cancelAll() {
        cancellables.forEach { $0.cancel() }
    }
    
    private func setTimer() {
        Timer.publish(every: 0.1, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.count < ThrowSandModel.images.count - 1{
                    self.count += 1
                } else {
                    self.cancelAll()
                }
                
                self.currentImage = ThrowSandModel.images[self.count]
            }
            .store(in: &cancellables)
    }
    
    private func setAudio() {
        do {
            audioPlayer = try AudioService(soundCase: .throwSand).getSound()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    private func playSound() {
        audioPlayer?.play()
    }
    
    private func stopSound() {
        audioPlayer?.stop()
    }
    
    public func changePosition() {
        position = ThrowSandModel.finalPosition
    }
    
    private func setActions() {
        playSound()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            guard let self = self else { return }
            self.frameOpacity = 0.0
            self.stopSound()
        }
    }
}

