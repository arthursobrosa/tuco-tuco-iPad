import SwiftUI

struct TucoStandingView: View {
    @StateObject private var vm = TucoStandingViewModel()
    
    let isOutside: Bool
    
    @Binding var isTalking: Bool
    @Binding var numberOfSqueaks: Int
    
    var body: some View {
        vm.currentImage
            .resizable()
            .scaledToFit()
            .frame(width: formatSize(value: 600, with: .width))
            .position(vm.position)
            .onAppear {
                vm.isOutside = isOutside
                vm.isTalking = isTalking
                vm.numberOfSqueaks = numberOfSqueaks
            }
            .onChange(of: numberOfSqueaks) { _, newValue in  
                vm.numberOfSqueaks = newValue
            }
            .onChange(of: isTalking) { _, newValue in
                vm.isTalking = newValue
            }
            .onChange(of: vm.isTalking) { _, newValue in
                isTalking = vm.isTalking
            }
            .onDisappear {
                vm.cancelAll()
            }
    }
}

