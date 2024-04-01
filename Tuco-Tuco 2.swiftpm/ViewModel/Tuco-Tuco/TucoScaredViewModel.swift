import SwiftUI
import Combine

class TucoScaredViewModel: ObservableObject {
    @Published var count = 0
    @Published var currentImage = TucoScaredModel.images[0]
    @Published var currentWidth = TucoScaredModel.widths[0]
    @Published var currentPosition = TucoScaredModel.positions[0]
    
    @Published var opacity = 1.0
    @Published var tucoHasDisappeared = false
    
    private var getOutsideCancellable: AnyCancellable?
    private var lookToTheSideCancellable: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getOutside()
        setAppearence()
    }
    
    private func cancelAll() {
        cancellables.forEach { $0.cancel() }
    }
    
    private func getOutside() {
        getOutsideCancellable = Timer.publish(every: 0.2, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.count < 2 {
                    self.count += 1
                } else {
                    self.getOutsideCancellable?.cancel()
                    self.lookToTheSide()
                    self.delayBeforeGoingInside()
                }
            }
    }
    
    private func setAppearence() {
        $count
            .sink { [weak self] count in
                guard let self = self else { return }
                
                self.currentImage = TucoScaredModel.images[count]
                self.currentWidth = TucoScaredModel.widths[count]
                self.currentPosition = TucoScaredModel.positions[count]
            }
            .store(in: &cancellables)
    }
    
    private func lookToTheSide() {
        lookToTheSideCancellable = Timer.publish(every: 0.5, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.count == 3 {
                    self.count -= 1
                } else {
                    self.count += 1
                }
            }
    }
    
    private func delayBeforeGoingInside() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            
            self.lookToTheSideCancellable?.cancel()
            self.goInside()
        }
    }
    
    private func goInside() {
        Timer.publish(every: 0.2, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.count > 0 {
                    self.count -= 1
                } else {
                    self.opacity = 0.0
                    self.tucoHasDisappeared = true
                    self.cancelAll()
                }
            }
            .store(in: &cancellables)
    }
}

