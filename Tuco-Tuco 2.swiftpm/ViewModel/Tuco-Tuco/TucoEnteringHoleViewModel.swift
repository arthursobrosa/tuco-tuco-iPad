import SwiftUI
import Combine

class TucoEnteringHoleViewModel: ObservableObject {
    @Published var count = 0
    @Published var degrees = 0.0
    @Published var opacity = 1.0
    @Published var position = TucoEnteringHoleModel.initialPosition
    
    @Published var goToNextPage = false
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setTimer()
        nextActions()
    }
    
    private func cancelAll() {
        cancellables.forEach { $0.cancel() }
    }
    
    private func setTimer() {
        Timer.publish(every: 0.2, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.count += 1
                self.position = TucoEnteringHoleModel.nextPosition(self.position)
                self.degrees += 10
            }
            .store(in: &cancellables)
    }
    
    private func nextActions() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            self.opacity = 0.0
            self.goToNextPage = true
            self.cancelAll()
        }
    }
}

