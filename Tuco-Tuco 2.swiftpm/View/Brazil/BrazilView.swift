import SwiftUI

struct BrazilView: View {
    @StateObject private var vm = BrazilViewModel()
    
    var body: some View {
        vm.currentImage
            .resizable()
            .scaledToFit()
            .frame(width: formatSize(value: 370, with: .width))
            .position(CGPoint(x: formatSize(value: 210, with: .width), y: formatSize(value: 300, with: .height)))
            .opacity(vm.opacity)
            .onAppear {
                withAnimation(Animation.linear(duration: 0.5)) {
                    vm.showMap()
                }
            }
            .onChange(of: vm.isMapHidden) { _, _ in
                withAnimation(Animation.linear(duration: 0.5)) {
                    vm.hideMap()
                }
            }
            .onChange(of: vm.hasImageChanged) { _, _ in
                withAnimation(Animation.linear(duration: 2)) {
                    vm.changeImage()
                }
            }
    }
}

