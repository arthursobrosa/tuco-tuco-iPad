import SwiftUI
import Combine

class GuyLeavingViewModel: ObservableObject {
    let guyIndex: Int
    var imageName = ""
    @Published var count = 0
    @Published var currentImage = Image("firstGuy0")
    @Published var position = CGPoint()
    var finalPosition = CGPoint()
    @Published var animationTime = 0.0
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init(guyIndex: Int) {
        self.guyIndex = guyIndex
        imageName = (guyIndex == 0 ? "first" : "second") + "Guy"
        position = guyIndex == 0 ? GuysLeavingModel.firstGuyInitialPosition : GuysLeavingModel.secondGuyInitialPosition
        finalPosition = guyIndex == 0 ? GuysLeavingModel.firstGuyFinalPosition : GuysLeavingModel.secondGuyFinalPosition
        animationTime = guyIndex == 0 ? GuysLeavingModel.firstGuyAnimationTime : GuysLeavingModel.secondGuyAnimationTime
        setTimer()
        setImage()
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
            }
            .store(in: &cancellables)
    }
    
    private func setImage() {
        $count
            .sink { [weak self] count in
                guard let self = self else { return }
                
                self.currentImage = Image("\(self.imageName)" + "\(count % 5)")
            }
            .store(in: &cancellables)
    }
    
    public func walk() {
        position = finalPosition
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationTime) { [weak self] in
            guard let self = self else { return }
            
            self.cancelAll()
        }
    }
}

