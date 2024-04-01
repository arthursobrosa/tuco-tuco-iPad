import SwiftUI

struct ThrowSandView: View {
    @StateObject private var vm = ThrowSandViewModel()
    
    var body: some View {
        vm.currentImage
            .resizable()
            .scaledToFit()
            .frame(width: formatSize(value: 200, with: .width))
            .opacity(vm.frameOpacity)
            .position(vm.position)
            .onAppear {
                withAnimation(Animation.linear(duration: 0.3)) {
                    vm.changePosition()
                }
            }
    }
}

