import SwiftUI

struct QueroView: View {
    @StateObject private var vm = QueroViewModel()
    
    @Binding var isPlaying: Bool
    
    var body: some View {
        ZStack {
            if vm.isFlying {
                QueroFlyingView(isFlying: $vm.isFlying, isPlaying: $isPlaying)
            }
        }
        .onChange(of: isPlaying) { _, _ in
            vm.cancelAll()
        }
    }
}

