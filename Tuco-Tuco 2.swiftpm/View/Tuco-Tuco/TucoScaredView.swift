import SwiftUI

struct TucoScaredView: View {
    @StateObject private var vm = TucoScaredViewModel()
    
    @Binding var tucoHasDisappeared: Bool
    
    var body: some View {
        vm.currentImage
            .resizable()
            .scaledToFit()
            .frame(width: vm.currentWidth)
            .opacity(vm.opacity)
            .position(vm.currentPosition)
            .onChange(of: vm.tucoHasDisappeared) { _, newValue in
                tucoHasDisappeared = newValue
            }
    }
}

