import SwiftUI
import AVFoundation

class CarOnBeachViewModel: ObservableObject {
    @Published var showTucoStanding = true
    @Published var isTalking = false
    @Published var startSpeech = false
    @Published var numberOfSqueaks = TextAndSqueaks.carOnBeachSqueaks[0]
    @Published var tucoSpeech = TextAndSqueaks.carOnBeachTexts[0]
    
    @Published var showOkButton = false
    
    @Published var showCarView = false
    
    @Published var showSignView = false
    @Published var isSignPositioned = false
    
    @Published var helpTextOpacity = 0.0
    
    private var audioPlayer: AVAudioPlayer? = nil
    
    
    let chronologyDelays = [0.5, 2.0, 3.5, 5.5]
    
    init() {
        delayAndStartSpeech()
        startChronology()
        setAudio()
    }
    
    private func setAudio() {
        do {
            let audio = try AudioService(soundCase: .engine).getSound()
            audio.numberOfLoops = -1
            audio.volume = 0.4
            audioPlayer = audio
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    private func playSound() {
        audioPlayer?.play()
    }
    
    public func stopSound() {
        audioPlayer?.stop()
    }
    
    private func delayAndStartSpeech() {
        DispatchQueue.main.asyncAfter(deadline: .now() + chronologyDelays[0]) { [weak self] in
            guard let self = self else { return }
            
            self.startSpeech = true
            self.isTalking = true
        }
    }
    
    private func startChronology() {
        for i in 0..<TextAndSqueaks.carOnBeachTexts.count - 1 {
            makeDelay(of: chronologyDelays[i + 1], with: i + 1)
        }
    }
    
    private func makeDelay(of delay: Double, with speechIndex: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }
            
            self.isTalking = true
            self.tucoSpeech = TextAndSqueaks.carOnBeachTexts[speechIndex]
            self.numberOfSqueaks = TextAndSqueaks.carOnBeachSqueaks[speechIndex]
            
            if speechIndex == 3 {
                self.playSound()
                self.enableOkButton()
            }
        }
    }
    
    private func enableOkButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            
            self.showOkButton = true
        }
    }
    
    public func volumeUp() {
        audioPlayer?.volume = 1.0
    }
}

