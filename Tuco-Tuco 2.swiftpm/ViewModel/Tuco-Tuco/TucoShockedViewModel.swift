import SwiftUI
import Combine

class TucoShockedViewModel: ObservableObject {
    @Published var count = 0
    @Published var currentImage = TucoShockedModel.images[0]
    @Published var scale = 1.0
    
    @Published var isShocking = true
    @Published var nextMove = false
    
    let chronologyDelays: [Double] = [0.2, 1.3, 1.4]
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setTimer()
        setImage()
        setChronology()
    }
    
    private func cancelAll() {
        cancellables.forEach { $0.cancel() }
    }
    
    private func setTimer() {
        Timer.publish(every: 0.1, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.count += 1
            }
            .store(in: &cancellables)
    }
    
    private func setImage() {
        $count
            .combineLatest($isShocking, $nextMove)
            .sink { [weak self] (count, isShocking, nextMove) in
                guard let self = self else { return }
                if isShocking {
                    self.currentImage = TucoShockedModel.images[count % TucoShockedModel.images.count]
                } else {
                    if nextMove {
                        self.currentImage = TucoShockedModel.images[3]
                        self.cancelAll()
                    } else {
                        self.currentImage = TucoShockedModel.images[1]
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func setChronology() {
        for i in 0..<chronologyDelays.count {
            makeDelays(of: chronologyDelays[i], with: i)
        }
    }
    
    private func makeDelays(of delay: Double, with index: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }
            self.isShocking.toggle()
            
            if index == 2 {
                self.nextMove = true
            }
        }
    }
    
    public func changeScale() {
        scale = 1.7
    }
    
    public func resetScale() {
        scale = 1.0
    }
}

