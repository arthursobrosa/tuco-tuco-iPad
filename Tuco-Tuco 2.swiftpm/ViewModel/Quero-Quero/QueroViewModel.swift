import SwiftUI
import Combine

class QueroViewModel: ObservableObject {
    @Published var currentImage = Image("quero0")
    private let allImages = QueroModel.images
    
    @Published var isFlying = true
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setTimer()
    }
    
    public func cancelAll() {
        cancellables.forEach { $0.cancel() }
    }
    
    private func setTimer() {
        Timer.publish(every: 7, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.isFlying = true
            }
            .store(in: &cancellables)
    }
}

