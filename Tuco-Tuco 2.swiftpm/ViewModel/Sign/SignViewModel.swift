import SwiftUI
import AVFoundation

class SignViewModel: ObservableObject {
    @Published var signPosition = SignModel.draggableSignOriginalPosition
    @Published var gestureLocation = CGPoint()
    let originalPosition = SignModel.draggableSignOriginalPosition
    
    @Published var isDraggable = true
    
    private var audioPlayer: AVAudioPlayer? = nil
    
    init() {
        setAudio()
    }
    
    public func checkFencePosition() -> Bool {
        if SignModel.rangeX.contains(gestureLocation.x) && SignModel.rangeY.contains(gestureLocation.y) {
            signPosition = gestureLocation
            
            return true
        } else {
            signPosition = originalPosition
            
            return false
        }
    }
    
    private func setAudio() {
        do {
            audioPlayer = try AudioService(soundCase: .correct).getSound()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    public func playSound() {
        audioPlayer?.play()
    }
}

