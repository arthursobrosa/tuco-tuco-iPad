import SwiftUI

struct TucoShockedView: View {
    @StateObject private var vm = TucoShockedViewModel()
    
    var body: some View {
        vm.currentImage
            .resizable()
            .scaledToFit()
            .frame(width: formatSize(value: 600, with: .width))
            .scaleEffect(vm.scale)
            .position(CGPoint(x: UIScreen.main.bounds.minX + formatSize(value: 230, with: .width), y: UIScreen.main.bounds.midY + formatSize(value: 232, with: .height)))
            .onAppear {
                withAnimation(Animation.linear(duration: 0.7)) {
                    vm.changeScale()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    withAnimation(Animation.linear(duration: 0.7)) {
                        vm.resetScale()
                    }
                }
            }
    }
}

