import SwiftUI

struct QueroFlyingView: View {
    @StateObject private var vm = QueroFlyingViewModel()
    
    @Binding var isFlying: Bool
    @Binding var isPlaying: Bool
    
    var body: some View {
        vm.currentImage
            .resizable()
            .frame(width: vm.currentSize.width, height: vm.currentSize.height)
            .position(vm.currentPosition)
            .onAppear {
                withAnimation(Animation.linear(duration: 4)) {
                    vm.changePosition() 
                }
            }
            .onChange(of: vm.isFlying) { _, newValue in
                self.isFlying = newValue
            }
            .onChange(of: isPlaying) { _, newValue in
                vm.isFlying = newValue 
                vm.cancelAll()
            }
    }
}

