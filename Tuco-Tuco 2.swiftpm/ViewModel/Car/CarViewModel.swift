import SwiftUI
import Combine

class CarViewModel: ObservableObject {
    @Published var count = 0
    @Published var currentImage = Image("car0")
    @Published var position = CarModel.initialPosition
    @Published var flipCar = false
    let animationDuration = 4.0
    
    
    private var cancellabels = Set<AnyCancellable>()
    
    init() {
        setTimer()
        setImage()
        setFlipCar()
    }
    
    private func cancelAll() {
        cancellabels.forEach { $0.cancel() }
    }
    
    private func setTimer() {
        Timer.publish(every: 0.2, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.count += 1
            }
            .store(in: &cancellabels)
    }
    
    private func setImage() {
        $count
            .sink { [weak self] count in
                guard let self = self else { return }
                
                self.currentImage = Image("car" + "\(count % 2)")
            }
            .store(in: &cancellabels)
    }
    
    public func drive() {
        position = CarModel.finalPosition
    }
    
    private func setFlipCar() {
        Timer.publish(every: animationDuration, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.flipCar.toggle()
            }
            .store(in: &cancellabels)
    }
}

