import SwiftUI
import Combine

class TucoEscapingViewModel: ObservableObject {
    @Published var count = 0
    @Published var currentImage = TucoEscapingModel.images[0]
    
    @Published var isTucoEscaping = false
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setTimer()
        setFirstImages()
    }
    
    private func cancelAll() {
        cancellables.forEach { $0.cancel() }
    }
    
    private func setTimer() {
        Timer.publish(every: 0.2, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if !self.isTucoEscaping {
                    if self.count < 7 {
                        self.count += 1
                    } else {
                        self.isTucoEscaping = true
                        self.count = 3
                    }
                } else {
                    if self.count < TucoEscapingModel.images.count - 1 {
                        self.count += 1
                    } else {
                        self.cancelAll()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func setFirstImages() {
        $count
            .combineLatest($isTucoEscaping)
            .sink { [weak self] (count, isSandFalling) in
                guard let self = self else { return }
                
                if !isSandFalling {
                    self.currentImage = TucoEscapingModel.images[count % 4]
                } else {
                    self.currentImage = TucoEscapingModel.images[count]
                }
            }
            .store(in: &cancellables)
    }
}

