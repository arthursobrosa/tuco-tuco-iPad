import SwiftUI

struct TucoDiggingView: View {
    @StateObject private var vm = TucoDiggingViewModel()
    
    @Binding var enterHole: Bool
    
    var body: some View {
        ZStack {
            vm.currentImage
                .resizable()
                .scaledToFit()
                .frame(width: TucoDiggingModel.width)
                .opacity(vm.frameOpacity)
                .position(TucoDiggingModel.position)
            
            if vm.throwSand {
                ThrowSandView()
            }
        }
        .onChange(of: vm.enterHole) { _, newValue in
            enterHole = newValue
        }
    }
}

