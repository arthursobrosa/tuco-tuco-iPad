import SwiftUI

struct FenceView: View {
    @StateObject var vm: FenceViewModel
    
    var body: some View {
        vm.fenceImage
            .resizable()
            .scaledToFit()
            .frame(width: vm.fenceWidth)
            .position(vm.fencePosition)
    }
}

