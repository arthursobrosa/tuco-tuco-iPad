import SwiftUI

class InitialPageViewModel: ObservableObject {
    @Published var presentBeachView = true
    @Published var presentDuneTunnelView = false
    @Published var presentShakingView = false
    @Published var presentBeachGoersView = false
    @Published var presentCarView = false
    @Published var presentDogView = false
    @Published var presentLastView = false
}

