import SwiftUI
import Combine

class TucoDiggingViewModel: ObservableObject {
    @Published var count = 0
    @Published var throwSand = false
    @Published var currentImage = TucoDiggingModel.images[0]
    @Published var frameOpacity = 1.0
    @Published var enterHole = false
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setAnimationTimer()
        setThrowSandTimer()
        setImage()
        setNextActions()
    }
    
    public func cancelAll() {
        cancellables.forEach { $0.cancel() }
    }
    
    private func setAnimationTimer() {
        Timer.publish(every: 0.15, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.count += 1
            }
            .store(in: &cancellables)
    }
    
    private func setThrowSandTimer() {
        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.throwSand.toggle()
            }
            .store(in: &cancellables)
    }
    
    private func setImage() {
        $count
            .sink { [weak self] count in
                guard let self = self else { return }
                
                self.currentImage = TucoDiggingModel.images[count % TucoDiggingModel.images.count]
            }
            .store(in: &cancellables)
    }
    
    private func setNextActions() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            guard let self = self else { return }
            
            self.cancelAll()
            self.frameOpacity = 0.0
            self.enterHole = true
        }
    }
}

