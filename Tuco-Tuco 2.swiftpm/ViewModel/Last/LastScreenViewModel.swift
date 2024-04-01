import SwiftUI

class LastScreenViewModel: ObservableObject {
    @Published var isPlayingWaveSound = true
    
    @Published var showStandingTuco = true
    
    @Published var isTalking = false
    @Published var numberOfSqueaks = TextAndSqueaks.lastSqueaks[0]
    @Published var tucoSpeech = TextAndSqueaks.lastTexts[0]
    @Published var showSpeech = false
    
    @Published var showPeaceTuco = false
    
    @Published var backgroundOpacity = 1.0
    
    let chronologyDelays = [0.5, 2.5, 6.5]
    
    @Published var showLastButtons = false
    @Published var lastButtonsOpacity = 0.0
    
    @Published var viewOpacity = 0.0
    
    @Published var showInfoView = false
    @Published var showCreditsView = false
    
    init() {
        delayAndStartPresentation()
    }
    
    private func delayAndStartPresentation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            
            self.delayAndStartSpeaking()
            self.startChronology()
        }
    }
    
    private func delayAndStartSpeaking() {
        DispatchQueue.main.asyncAfter(deadline: .now() + chronologyDelays[0]) { [weak self] in
            guard let self = self else { return }
            
            self.isTalking = true
            self.showSpeech = true
        }
    }
    
    private func startChronology() {
        for i in 0..<TextAndSqueaks.lastTexts.count - 1 {
            makeDelay(of: chronologyDelays[i + 1], with: i + 1)
        }
    }
    
    private func makeDelay(of delay: Double, with speechIndex: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }
            
            self.isTalking = true
            self.tucoSpeech = TextAndSqueaks.lastTexts[speechIndex]
            self.numberOfSqueaks = TextAndSqueaks.lastSqueaks[speechIndex]
            
            if speechIndex == 2 {
                self.delayAndShowPeaceTuco()
            }
        }
    }
    
    private func delayAndShowPeaceTuco() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            
            self.showStandingTuco = false
            self.showSpeech = false
            self.showPeaceTuco = true
            self.showLastButtons = true
        }
    }
    
    public func changeLastButtonsOpacity() {
        lastButtonsOpacity = 1.0
    }
    
    public func changeViewOpacity() {
        backgroundOpacity = 0.0
    }
}

