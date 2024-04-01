import SwiftUI
import Combine
import AVFoundation

class DuneTunnelViewModel: ObservableObject {
    @Published var viewColor = Color.black
    
    @Published var startView = false
    
    @Published var showTunnel = false
    
    @Published var presentStandingTuco = false
    @Published var startSpeech = false
    @Published var isTalking = false
    @Published var numberOfSqueaks = TextAndSqueaks.insideSqueaks[0]
    @Published var tucoSpeech = TextAndSqueaks.insideTexts[0]
    
    @Published var showTucoShocked = false
    
    @Published var showHelpButton = false
    
    @Published var showGrass = false
    
    @Published var helpTextOpacity = 0.0
    
    
    var allGrasses: [GrassView] = {
        var views: [GrassView] = []
        
        for i in 0..<GrassModel.numberOfGrass {
            let view = GrassView(vm: GrassViewModel(grassIndex: i))
            views.append(view)
        }
        
        return views
    }()
    
    private var audioPlayer: AVAudioPlayer? = nil
    
    private let chronologyDelays: [Double] = [0.5, 2.0, 4.0, 7.0, 9.5, 11.5]
    
    private var presentStandingTucoPublisher: AnyCancellable?
    
    init() {
        setStartView()
        setStartSpeech()
        setGrassAudio()
    }
    
    private func setGrassAudio() {
        do {
            let audio = try AudioService(soundCase: .grow).getSound()
            audio.volume = 15.0
            audioPlayer = audio
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    public func playGrassSound() {
        audioPlayer?.play()
    }
    
    private func setStartView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.startView = true
        }
    }
    
    public func changeColor() {
        viewColor = CustomColor.darkSand.color
    }
    
    private func setStartSpeech() {
        presentStandingTucoPublisher = $presentStandingTuco
            .sink { [weak self] value in
                guard let self = self else { return }
                
                if value {
                    self.delayAndStartSpeech()
                    self.presentStandingTucoPublisher?.cancel()
                }
            }
    }
    
    private func delayAndStartSpeech() {
        DispatchQueue.main.asyncAfter(deadline: .now() + chronologyDelays[0]) { [weak self] in
            guard let self = self else { return }
            self.startSpeech = true
            self.isTalking = true
            self.startChronology()
        }
    }
    
    private func startChronology() {
        for i in 1..<chronologyDelays.count {
            makeDelay(of: chronologyDelays[i], withIndex: i)
        }
    }
    
    private func makeDelay(of delay: Double, withIndex speechIndex: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }
            self.tucoSpeech = TextAndSqueaks.insideTexts[speechIndex]
            self.numberOfSqueaks = TextAndSqueaks.insideSqueaks[speechIndex]
            self.isTalking = true
            
            if speechIndex == 4 {
                self.showTucoShocked = true
            }
            
            if speechIndex == 5 {
                self.showTucoShocked = false
                self.setHelpButton()
            }
        }
    }
    
    private func setHelpButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }
            self.showHelpButton = true
        }
    }
}

