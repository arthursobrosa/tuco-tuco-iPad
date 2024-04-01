import SwiftUI

class TucoEnteringDenViewModel: ObservableObject {
    @Published var startDigging = false
    @Published var enterHole = false
    @Published var goToNextPage = false
}

