import SwiftUI
import Combine
import AVFoundation

class BeachGoersViewModel: ObservableObject {
    @Published var startPresentation = false
    @Published var opacity = 1.0
    
    @Published var count = 0
    @Published var currentImage = BeachGoersModel.images[0]
    
    @Published var showTucoScaredView = false
    @Published var tucoScaredHasDisappeared = false
    
    @Published var showTucoStandingView = false
    @Published var showTucoSpeech = false
    @Published var isTalking = false
    @Published var tucoSpeech = TextAndSqueaks.beachGoersTexts[0]
    @Published var numberOfSqueaks = TextAndSqueaks.beachGoersSqueaks[0]
    @Published var speechHasEnded = false
    
    private let chronologyDelays = [1.0, 2.5]
    
    @Published var showHelpButton = false
    
    @Published var showDraggableFences = false
    
    var allFences: [DraggableFenceView] = {
        var views: [DraggableFenceView] = []
        
        for i in 0..<FenceModel.draggableFencesPositions.count {
            let view = DraggableFenceView(vm: DraggableFenceViewModel(fenceIndex: i))
            views.append(view)
        }
        
        return views
    }()
    
    @Published var helpTextOpacity = 0.0
    
    @Published var arePeopleOverDune = true
    
    @Published var goToNextView = false
    
    private var audioPlayer: AVAudioPlayer? = nil
    
    
    private var tucoHasDisappearedPublisher: AnyCancellable?
    private var speechHasEndedPublisher: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setStartPresentation()
    }
    
    private func cancelAll() {
        cancellables.forEach { $0.cancel() }
    }
    
    private func setStartPresentation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            
            self.startPresentation = true
        }
    }
    
    private func initializeFunctions() {
        setTimer()
        setImage()
        setShowTucoScaredView()
        setShowTucoStandingView()
        setShowHelpButton()
        setAudio()
    }
    
    public func changeOpacity() {
        opacity = 0.0
        
        initializeFunctions()
    }
    
    private func setAudio() {
        do {
            let audio = try AudioService(soundCase: .beachGoers).getSound()
            audio.numberOfLoops = -1
            audio.volume = 0.75
            audioPlayer = audio
            audioPlayer?.play()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    private func stopAudio() {
        audioPlayer?.stop()
    }
    
    private func setTimer() {
        Timer.publish(every: 0.3, on: .main, in: .default)
            .autoconnect()
            .combineLatest($arePeopleOverDune)
            .sink { [weak self] (_, arePeopleOverDune) in
                guard let self = self else { return }
                
                if arePeopleOverDune {
                    if self.count < BeachGoersModel.images.count - 1 {
                        self.count += 1
                    } else {
                        self.count = 6
                    }
                } else {
                    self.cancelAll()
                    self.changeToEmptyBeachImage()
                }
            }
            .store(in: &cancellables)
    }
    
    private func setImage() {
        $count
            .sink { [weak self] count in
                guard let self = self else { return }
                
                self.currentImage = BeachGoersModel.images[count]
            }
            .store(in: &cancellables)
    }
    
    private func setShowTucoScaredView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            self.showTucoScaredView = true
        }
    }
    
    private func setShowTucoStandingView() {
        tucoHasDisappearedPublisher = $tucoScaredHasDisappeared
            .sink { [weak self] value in
                guard let self = self else { return }
                
                if value {
                    self.showTucoStandingView = true
                    self.delayBeforeStartingChronology()
                    self.tucoHasDisappearedPublisher?.cancel()
                }
            }
    }
    
    private func delayBeforeStartingChronology() {
        DispatchQueue.main.asyncAfter(deadline: .now() + chronologyDelays[0]) { [weak self] in
            guard let self = self else { return }
            
            self.isTalking = true
            self.showTucoSpeech = true
            self.startChronology()
        }
    }
    
    private func startChronology() {
        for i in 1..<chronologyDelays.count {
            makeDelay(of: chronologyDelays[i], with: i)
        }
    }
    
    private func makeDelay(of delay: Double, with speechIndex: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }
            
            self.isTalking = true
            self.tucoSpeech = TextAndSqueaks.beachGoersTexts[speechIndex]
            self.numberOfSqueaks = TextAndSqueaks.beachGoersSqueaks[speechIndex]
            
            if speechIndex == TextAndSqueaks.beachGoersTexts.count - 1 {
                self.speechHasEnded = true
            }
        }
    }
    
    private func setShowHelpButton() {
        speechHasEndedPublisher = $speechHasEnded
            .combineLatest($isTalking)
            .sink { [weak self] (speechHasEnded, isTalking) in
                guard let self = self else { return }
                
                if speechHasEnded && !isTalking {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.showHelpButton = true
                        self.speechHasEndedPublisher?.cancel()
                    }
                }
            }
    }
    
    private func changeToEmptyBeachImage() {
        currentImage = Image("duneTest")
        stopAudio()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            
            self.goToNextView = true
        }
    }
}

