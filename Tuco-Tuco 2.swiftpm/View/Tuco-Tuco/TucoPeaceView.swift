import SwiftUI

struct TucoPeaceView: View {
    @StateObject private var vm = TucoPeaceViewModel()
    
    var body: some View {
        Image("tucoPeace")
            .resizable()
            .scaledToFit()
            .frame(width: TucoPeaceModel.width)
            .position(vm.currentPosition)
            .onAppear {
                withAnimation(.linear(duration: 6)) {
                    vm.changePosition()
                }
            }
    }
}

