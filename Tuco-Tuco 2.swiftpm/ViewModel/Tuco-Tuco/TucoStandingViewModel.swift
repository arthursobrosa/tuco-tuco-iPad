import SwiftUI
import Combine
import AVFoundation

class TucoStandingViewModel: ObservableObject {
    @Published var isTalking = false
    @Published var numberOfSqueaks = 0
    @Published var currentImage = TucoStandingModel.images[0]
    @Published var count = 0
    @Published var isOutside = false
    @Published var position = CGPoint()
    
    private let allImages = TucoStandingModel.images
    
    private var cancellables = Set<AnyCancellable>()
    
    private var audioPlayer: AVAudioPlayer? = nil
    
    init() {
        setTimer()
        setImage()
        setPosition()
        setAudio()
        setIsPlayingSound()
    }
    
    public func cancelAll() {
        cancellables.forEach { $0.cancel() }
    }
    
    private func setAudio() {
        do {
            let audio = try AudioService(soundCase: .squeak).getSound()
            audio.volume = 0.3
            audio.numberOfLoops = -1
            audioPlayer = audio
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
    
    private func setIsPlayingSound() {
        $isTalking
            .sink { [weak self] value in
                guard let self = self else { return }
                
                if value {
                    self.playSound()
                    self.delayAndStopTalking()
                } else {
                    self.stopSound()
                }
            }
            .store(in: &cancellables)
    }
    
    private func delayAndStopTalking() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(numberOfSqueaks) * 0.5) { [weak self] in
            guard let self = self else { return }
            self.isTalking = false
        }
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
        $isTalking
            .combineLatest($count)
            .sink { [weak self] (isTalking, count) in
                guard let self = self else { return }
                
                if isTalking {
                    self.currentImage = allImages[count % allImages.count]
                } else {
                    self.currentImage = allImages[0]
                }
            }
            .store(in: &cancellables)
    }
    
    private func setPosition() {
        $isOutside
            .sink { [weak self] value in
                guard let self = self else { return }
                self.position = value ? TucoStandingModel.outsidePosition : TucoStandingModel.insidePosition
            }
            .store(in: &cancellables)
    }
}

