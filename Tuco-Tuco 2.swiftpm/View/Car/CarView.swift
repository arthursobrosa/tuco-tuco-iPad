import SwiftUI

struct CarView: View {
    @StateObject private var vm = CarViewModel()
    
    var body: some View {
        vm.currentImage
            .resizable()
            .scaledToFit()
            .frame(width: CarModel.width)
            .scaleEffect(x: vm.flipCar ? -1 : 1, y: 1)
            .position(vm.position)
            .onAppear {
                withAnimation(.linear(duration: vm.animationDuration).repeatForever(autoreverses: true)) {
                    vm.drive()
                }
            }
    }
}

