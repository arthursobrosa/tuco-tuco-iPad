import SwiftUI

struct InitialPageView: View {
    @StateObject private var vm = InitialPageViewModel()
    
    var body: some View {
        ZStack {
            if vm.presentBeachView {
                BeachView(presentDuneTunnelView:  $vm.presentDuneTunnelView)
            }
            
            if vm.presentDuneTunnelView {
                DuneTunnelView(presentShakingView: $vm.presentShakingView)
            }
            
            if vm.presentShakingView {
                ShakingView(presentBeachGoersView: $vm.presentBeachGoersView)
            }
            
            if vm.presentBeachGoersView {
                BeachGoersView(goToNextView: $vm.presentCarView) 
            }
            
            if vm.presentCarView {
                CarOnBeachView(goToNextView: $vm.presentDogView)
            }
            
            if vm.presentDogView {
                DogView(goToNextView: $vm.presentLastView)
            }
            
            if vm.presentLastView {
                LastScreenView()
            }
        }
        .onChange(of: vm.presentDuneTunnelView) { _, newValue in
            if newValue {
                vm.presentBeachView = false
            }
        }
    }
}

