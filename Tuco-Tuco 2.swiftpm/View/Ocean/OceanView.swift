import SwiftUI

struct OceanView: View {
    @StateObject private var vm = OceanViewModel()
    
    @Binding var isPlaying: Bool
    
    var body: some View {
        vm.currentImage
            .resizable()
            .frame(width: UIScreen.main.bounds.maxX, height: UIScreen.main.bounds.maxY)
            .ignoresSafeArea()
            .onChange(of: isPlaying) { _, newValue in
                vm.isPlaying = isPlaying
            }
    }
}

