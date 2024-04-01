import SwiftUI
import AVFoundation

class ShakingViewModel: ObservableObject {
    @Published var degrees = 0.0
    
    @Published var showTucoStanding = false
    @Published var isTalking = false
    @Published var numberOfSqueaks = TextAndSqueaks.shakingSqueaks[0]
    @Published var tucoSpeech = TextAndSqueaks.shakingTexts[0]
    @Published var startSpeech = false
    
    private let chronologyDelays = [2.5, 4.5]
    
    @Published var showHelpButton = false
    
    @Published var viewScale = 1.0
    @Published var opacity = 0.0
    @Published var startTransition = false
    
    private var audioPlayer: AVAudioPlayer? = nil
    
    init() {
        setAudio()
        setTucoStanding()
    }
    
    public func shakeIt() {
        degrees = 3.0
    }
    
    private func setAudio() {
        do {
            let audio = try AudioService(soundCase: .earthQuake).getSound()
            audio.numberOfLoops = -1
            audioPlayer = audio
            audioPlayer?.play()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    public func stopSound() {
        audioPlayer?.stop()
    }
    
    private func setTucoStanding() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            guard let self = self else { return }
            
            self.showTucoStanding = true
            self.delayAndStartChronology()
        }
    }
    
    private func delayAndStartChronology() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            self.startSpeech = true
            self.isTalking = true
            self.startChronology()
        }
    }
    
    private func startChronology() {
        for i in 0..<chronologyDelays.count {
            makeDelay(of: chronologyDelays[i], with: i + 1)
        }
    }
    
    private func makeDelay(of delay: Double, with speechIndex: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }
            
            self.numberOfSqueaks = TextAndSqueaks.shakingSqueaks[speechIndex]
            self.tucoSpeech = TextAndSqueaks.shakingTexts[speechIndex]
            self.isTalking = true
            
            if speechIndex == 2 {
                self.setHelpButton()
            }
        }
    }
    
    private func setHelpButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            self.showHelpButton = true
        }
    }
    
    public func changeView() {
        opacity = 1.0
        viewScale = 10.0
    }
}

