import SwiftUI

struct GuyLeavingView: View, Identifiable {
    var id = UUID()
    
    @StateObject var vm: GuyLeavingViewModel
    
    var body: some View {
        vm.currentImage
            .resizable()
            .scaledToFit()
            .frame(height: GuysLeavingModel.guysHeight)
            .position(vm.position)
            .onAppear {
                withAnimation(.linear(duration: vm.animationTime)) {
                    vm.walk()
                }
            }
    }
}

