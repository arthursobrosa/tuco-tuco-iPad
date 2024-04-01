import SwiftUI
import Combine

class BeachViewModel: ObservableObject {
    @Published var playButtonClicked = false
    @Published var startPresentation = false
    
    @Published var isTalking = false
    @Published var numberOfSqueaks = TextAndSqueaks.outsideSqueaks[0]
    
    @Published var startSpeech = false
    
    @Published var speechText = TextAndSqueaks.outsideTexts[0]
    
    @Published var showMap = false
    
    @Published var showGoInsideButton = false
    @Published var goInside = false
    
    @Published var viewScale = 1.0
    @Published var viewPosition = BeachModel.initialPosition
    @Published var viewOpacity = 0.0
    
    @Published var goToNextPage = false
    
    @Published var isPlayingBeachSounds = true
    
    let chronologyDelays: [Double] = [1.2, 4.2, 10.0]
    
    private var playButtonPublisher: AnyCancellable?
    private var startPresentationPublisher: AnyCancellable?
    private var startSpeechPublisher: AnyCancellable?
    
    init() {
        setStartPresentation()
        setStartSpeech()
        setChronologyAndGoInsideButton()
    }
    
    private func setStartPresentation() {
        playButtonPublisher = $playButtonClicked
            .sink { [weak self] value in
                guard let self = self else { return }
                
                self.startPresentation = value
                
                if value {
                    self.playButtonPublisher?.cancel()
                }
            }
    }
    
    private func setStartSpeech() {
        startPresentationPublisher = $startPresentation
            .sink { [weak self] value in
                guard let self = self else { return }
                
                if value {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
                        guard let self = self else { return }
                        self.startSpeech = true
                        self.isTalking = true
                        self.startPresentationPublisher?.cancel()
                    }
                }
            }
    }
    
    private func setChronologyAndGoInsideButton() {
        startSpeechPublisher = $startSpeech
            .sink { [weak self] value in
                guard let self = self else { return }
                
                if value {
                    self.startChronology()
                    self.enableGoInsideButton()
                    self.startSpeechPublisher?.cancel()
                }
            }
    }
    
    private func startChronology() {
        for i in 0..<chronologyDelays.count {
            makeDelay(of: chronologyDelays[i], withIndex: i + 1)
        }
    }
    
    private func makeDelay(of delay: Double, withIndex speechIndex: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }
            
            self.speechText = TextAndSqueaks.outsideTexts[speechIndex]
            self.numberOfSqueaks = TextAndSqueaks.outsideSqueaks[speechIndex]
            self.isTalking = true
            
            if speechIndex == 2 {
                self.showMap = true
            }
        }
    }
    
    private func enableGoInsideButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 12.5) { [weak self] in
            guard let self = self else { return }
            
            self.showGoInsideButton = true
        }
    }
    
    public func changeViewLooks() {
        viewScale = 10.0
        viewPosition = BeachModel.finalPosition
        viewOpacity = 1.0
    }
}

