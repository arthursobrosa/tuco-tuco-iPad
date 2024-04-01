import SwiftUI
import Combine
import AVFoundation

class TucoWalkingInDenViewModel: ObservableObject {
    @Published var count = 0
    @Published var currentImage = TucoWalkingInDenModel.images[0]
    @Published var presentStandingTuco = false
    
    private var audioPlayer: AVAudioPlayer? = nil
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setTimer()
        setImage()
        setAudio()
    }
    
    private func cancelAll() {
        cancellables.forEach { $0.cancel() }
    }
    
    private func setAudio() {
        do {
            let audio: AVAudioPlayer = try AudioService(soundCase: .movingInTunnel).getSound()
            audio.numberOfLoops = 2
            audioPlayer = audio
            audioPlayer?.play()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    private func setTimer() {
        Timer.publish(every: 0.2, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if count < 11 {
                    self.count += 1
                } else {
                    self.count = 11
                }
            }
            .store(in: &cancellables)
    }
    
    private func setImage() {
        $count
            .sink { [weak self] count in
                guard let self = self else { return }
                self.currentImage = TucoWalkingInDenModel.images[count % TucoWalkingInDenModel.images.count]
                
                if count == 11 {
                    self.nextActions()
                }
            }
            .store(in: &cancellables)
    }
    
    private func nextActions() {
        cancelAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.presentStandingTuco = true
        }
    }
}

