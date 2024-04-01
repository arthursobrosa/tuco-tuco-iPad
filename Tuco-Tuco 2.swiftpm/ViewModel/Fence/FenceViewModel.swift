import SwiftUI

class FenceViewModel: ObservableObject {
    var fenceIndex = 0
    @Published var fencePosition = CGPoint()
    @Published var fenceWidth = CGFloat()
    @Published var fenceImage = Image("fence0")
    
    init(fenceIndex: Int) {
        self.fenceIndex = fenceIndex
        fencePosition = FenceModel.fencesPositions[fenceIndex]
        fenceWidth = FenceModel.fencesWidths[fenceIndex]
        fenceImage = Image("fence" + "\(fenceIndex)")
    }
}

