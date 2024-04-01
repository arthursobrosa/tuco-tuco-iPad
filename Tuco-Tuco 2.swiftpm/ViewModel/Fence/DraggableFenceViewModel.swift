import SwiftUI
import Combine

class DraggableFenceViewModel: ObservableObject {
    let fenceIndex: Int
    @Published var fencePosition = CGPoint()
    @Published var gestureLocation = CGPoint()
    @Published var originalPosition = CGPoint()
    
    @Published var isDraggable = true
    @Published var fenceOpacity = 1.0
    
    
    private var fenceOpacityPublisher: AnyCancellable?
    
    init(fenceIndex: Int) {
        self.fenceIndex = fenceIndex
        fencePosition = FenceModel.draggableFencesPositions[fenceIndex]
        originalPosition = fencePosition
        setPosition()
        setFenceOpacity()
    }
    
    private func setPosition() {
        fencePosition = FenceModel.draggableFencesPositions[fenceIndex]
    }
    
    public func checkFencePosition() -> Bool {
        if FenceModel.rangeX.contains(gestureLocation.x) && FenceModel.rangeY.contains(gestureLocation.y) {
            fencePosition = gestureLocation
            
            return true
        } else {
            fencePosition = originalPosition
            
            return false
        }
    }
    
    private func setFenceOpacity() {
        fenceOpacityPublisher = $isDraggable
            .sink { [weak self] value in
                guard let self = self else { return }
                
                if !value {
                    self.fenceOpacity = 0.0
                    self.fenceOpacityPublisher?.cancel()
                }
            }
    }
}

