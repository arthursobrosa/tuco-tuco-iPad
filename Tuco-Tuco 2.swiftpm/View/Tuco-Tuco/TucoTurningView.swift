import SwiftUI

struct TucoTurningView: View {
    @StateObject private var vm = TucoTurningViewModel()
    
    @Binding var startDigging: Bool
    
    var body: some View {
        Image(vm.currentFrame.rawValue)
            .resizable()
            .frame(width: vm.currentFrame.size.width, height: vm.currentFrame.size.height)
            .scaleEffect(vm.currentFrame.scale)
            .position(vm.currentFrame.position)
            .opacity(vm.frameOpacity)
            .onChange(of: vm.startDigging) { _, newValue in
                startDigging = newValue
            }
    }
}

