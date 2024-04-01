import SwiftUI
import Combine

class TucoTurningViewModel: ObservableObject {
    @Published var count = 0
    @Published var currentFrame = TurningFrame.tucoTurning0
    let turningFrames = TurningFrame.allCases
    
    @Published var frameOpacity = 1.0
    @Published var startDigging = false
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setFrames()
    }
    
    private func cancelAll() {
        cancellables.forEach { $0.cancel() }
    }
    
    private func setFrames() {
        Timer.publish(every: 0.2, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.count < self.turningFrames.count - 1 {
                    self.count += 1
                } else {
                    self.nextActions()
                }
                
                self.currentFrame = self.turningFrames[self.count]
            }
            .store(in: &cancellables)
    }
    
    private func nextActions() {
        cancelAll()
        frameOpacity = 0
        startDigging = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            guard let self = self else { return }
            self.startDigging = false
        }
    }
}

