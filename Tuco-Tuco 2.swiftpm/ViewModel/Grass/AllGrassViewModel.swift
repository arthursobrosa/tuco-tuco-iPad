import SwiftUI
import Combine

class AllGrassViewModel: ObservableObject {
    @Published var numberOfGrass = 0
    @Published var lastGrass = false
    @Published var makeItShake = false
    @Published var opacity = 1.0
    
    private var numberOfGrassPublisher: AnyCancellable?
    private var makeItShakePublisher: AnyCancellable?
    
    init() {
        setNumberOfGrass()
        setShakingView()
    }
    
    private func setNumberOfGrass() {
        numberOfGrassPublisher = $numberOfGrass
            .sink { [weak self] count in
                guard let self = self else { return }
                
                if count >= GrassModel.numberOfGrass - 1 {
                    self.lastGrass = true
                    self.numberOfGrassPublisher?.cancel()
                }
            }
    }
    
    private func setShakingView() {
        makeItShakePublisher = $makeItShake
            .sink { [weak self] value in
                guard let self = self else { return }
                
                if value {
                    self.opacity = 0.0
                    self.makeItShakePublisher?.cancel()
                }
            }
    }
}

