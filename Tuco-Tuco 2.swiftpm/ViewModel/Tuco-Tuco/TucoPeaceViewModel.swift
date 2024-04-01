import SwiftUI

class TucoPeaceViewModel: ObservableObject {
    @Published var currentPosition = TucoPeaceModel.originalPosition
    
    public func changePosition() {
        currentPosition = CGPoint(
            x: TucoPeaceModel.originalPosition.x,
            y: TucoPeaceModel.originalPosition.y + formatSize(value: 720, with: .height)
        )
    }
}

