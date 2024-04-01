import SwiftUI

struct TucoEnteringHoleView: View {
    @StateObject private var vm = TucoEnteringHoleViewModel()
    
    @Binding var goToNextPage: Bool
    
    var body: some View {
        Image("tucoWalking0")
            .resizable()
            .scaledToFit()
            .frame(width: formatSize(value: 300, with: .width))
            .rotationEffect(.degrees(vm.degrees))
            .opacity(vm.opacity)
            .position(vm.position)
            .onChange(of: vm.goToNextPage) { _, newValue in
                goToNextPage = newValue
            }
    }
}

