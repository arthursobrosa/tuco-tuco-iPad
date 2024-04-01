import SwiftUI

struct TucoEnteringDenView: View {
    @StateObject private var vm = TucoEnteringDenViewModel()
    
    @Binding var goToNextPage: Bool
    
    var body: some View {
        ZStack {
            TucoTurningView(startDigging: $vm.startDigging)
            
            if vm.startDigging {
                TucoDiggingView(enterHole: $vm.enterHole)
            }
            
            if vm.enterHole {
                TucoEnteringHoleView(goToNextPage: $vm.goToNextPage)
            }
            
            MountView()
        }
        .onChange(of: vm.goToNextPage) { _, newValue in
            goToNextPage = newValue
        }
    }
}

