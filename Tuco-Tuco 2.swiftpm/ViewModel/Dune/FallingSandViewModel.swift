import SwiftUI
import Combine

class FallingSandViewModel: ObservableObject {
    @Published var degrees = 0.0
    
    @Published var count = 0
    @Published var currentImage = FallingSandModel.images[0]
    @Published var currentPosition = FallingSandModel.originalPosition
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setTimer()
        setImageAndPosition()
    }
    
    private func cancelAll() {
        cancellables.forEach { $0.cancel() }
    }
    
    public func shakeIt() {
        degrees = 3.0
    }
    
    private func setTimer() {
        Timer.publish(every: 0.15, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.count += 1
            }
            .store(in: &cancellables)
    }
    
    private func setImageAndPosition() {
        $count
            .sink { [weak self] count in
                guard let self = self else { return }
                
                var index: Int = 0
                
                if count < FallingSandModel.images.count {
                    index = count % FallingSandModel.images.count
                } else {
                    index = (count % 3) + (FallingSandModel.images.count - 3)
                }
                
                self.currentImage = FallingSandModel.images[index]
                self.currentPosition = CGPoint(
                    x: FallingSandModel.originalPosition.x,
                    y: FallingSandModel.originalPosition.y + formatSize(value: Double(index) * 40, with: .height)
                )
            }
            .store(in: &cancellables)
    }
}

