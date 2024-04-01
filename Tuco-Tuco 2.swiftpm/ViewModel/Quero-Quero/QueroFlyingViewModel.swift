import SwiftUI
import Combine
import AVFoundation

class QueroFlyingViewModel: ObservableObject {
    @Published var currentImage = Image("quero0")
    @Published var count = 0
    
    private let allImages = QueroModel.images
    
    @Published var currentPosition = QueroModel.initialPosition
    @Published var currentSize = QueroModel.largeSize
    
    @Published var isFlying = true
    
    @Published var isPlaying = false
    
    private var audioPlayer: AVAudioPlayer? = nil
    
    
    private var cancellables = Set<AnyCancellable>()
    
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
        Timer.publish(every: 0.45, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.count += 1
            }
            .store(in: &cancellables)
    }
    
    private func setImage() {
        $count
            .sink { [weak self] count_ in
                guard let self = self else { return }
                self.currentImage = self.allImages[count % self.allImages.count]
                
                if count % allImages.count == 0 {
                    self.currentSize = QueroModel.largeSize
                } else {
                    self.currentSize = QueroModel.smallSize
                }
            }
            .store(in: &cancellables)
    }
    
    public func changePosition() {
        currentPosition = QueroModel.finalPosition
    }
    
    private func setAudio() {
        do {
            let audio = try AudioService(soundCase: .queroBird).getSound()
            audio.volume = 0.4
            self.audioPlayer = audio
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    private func playAudio() {
        self.audioPlayer?.play()
    }
    
    private func stopAudio() {
        self.audioPlayer?.stop()
    }
    
    private func setIsPlaying() {
        $isPlaying
            .sink { [weak self] isPlaying in
                guard let self = self else { return }
                
                if isPlaying {
                    self.playAudio()
                } else {
                    self.stopAudio()
                }
            }
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            
            self.isPlaying = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            guard let self = self else { return }
            
            self.isPlaying = false
            self.isFlying = false
        }
    }
}

