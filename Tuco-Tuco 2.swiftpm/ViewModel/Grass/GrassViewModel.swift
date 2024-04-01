import SwiftUI
import Combine
import AVFoundation

class GrassViewModel: ObservableObject {
    @Published var showGrass = false
    @Published var count = 0
    @Published var currentWidth = GrassModel.widths[0]
    @Published var currentPosition = CGPoint()
    private var delay: Double = 0
    
    let grassIndex: Int
    
    @Published var originalPosition = CGPoint()
    @Published var gestureLocation = CGPoint()
    
    @Published var scale = 1.0
    @Published var opacity = 1.0
    
    private var audioPlayer: AVAudioPlayer? = nil
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init(grassIndex: Int) {
        self.grassIndex = grassIndex
        currentPosition = GrassModel.positions[grassIndex]
        delay = GrassModel.growthDelays[grassIndex]
        delayAndStart()
        setAudio()
    }
    
    private func cancelAll() {
        cancellables.forEach { $0.cancel() }
    }
    
    private func delayAndStart() {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }
            self.showGrass = true
            self.setTimer()
            self.setWidthAndPosition()
        }
    }
    
    private func setTimer() {
        Timer.publish(every: 0.1, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.count < GrassModel.widths.count - 1 {
                    self.count += 1
                }
            }
            .store(in: &cancellables)
    }
    
    private func setWidthAndPosition() {
        $count
            .sink { [weak self] count in
                guard let self = self else { return }
                
                self.currentWidth = GrassModel.widths[count]
                self.currentPosition = CGPoint(x: self.currentPosition.x, y: self.currentPosition.y - formatSize(value: 5, with: .height))
                
                if count >= GrassModel.widths.count - 1 {
                    self.originalPosition = self.currentPosition
                    self.cancelAll()
                }
            }
            .store(in: &cancellables)
    }
    
    public func checkGrassPosition() -> Bool {
        if GrassModel.rangeX.contains(gestureLocation.x) && GrassModel.rangeY.contains(gestureLocation.y) {
            currentPosition = gestureLocation
            
            return true
        } else {
            currentPosition = originalPosition
            
            return false
        }
    }
    
    public func eatGrass() {
        scale = 0.0
        opacity = 0.0
    }
    
    private func setAudio() {
        do {
            audioPlayer = try AudioService(soundCase: .eating).getSound()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    public func playSound() {
        audioPlayer?.play()
    }
}

