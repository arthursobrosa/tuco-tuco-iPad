import SwiftUI
import Combine
import AVFoundation

class OceanViewModel: ObservableObject {
    @Published var count = 0
    private var cancellables = Set<AnyCancellable>()
    
    private let allImages = OceanModel.images
    @Published var currentImage = OceanModel.images[0]
    
    private var audioPlayer: AVAudioPlayer? = nil
    
    @Published var isPlaying = true
    
    init() {
        setTimer()
        setImage()
        setAudio()
        setIsPlaying()
    }
    
    public func cancelAll() {
        cancellables.forEach { $0.cancel() }
    }
    
    private func setTimer() {
        Timer.publish(every: 0.2, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.count += 1
            }
            .store(in: &cancellables)
    }
    
    private func setImage() {
        $count
            .sink { [weak self] count in
                guard let self = self else { return }
                
                self.currentImage = self.allImages[count % self.allImages.count]
            }
            .store(in: &cancellables)
    }
    
    private func setAudio() {
        do {
            let audio = try AudioService(soundCase: .waves).getSound()
            audio.volume = 0.3
            audio.numberOfLoops = -1
            self.audioPlayer = audio
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
    
    private func setIsPlaying() {
        $isPlaying
            .sink { [weak self] isPlaying in
                guard let self = self else { return }
                if isPlaying {
                    self.playSound()
                } else {
                    self.stopSound()
                    self.cancelAll()
                }
            }
            .store(in: &cancellables)
    }
}

