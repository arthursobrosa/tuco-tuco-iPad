import SwiftUI

struct FallingSandView: View {
    @StateObject private var vm = FallingSandViewModel()
    
    var body: some View {
        HStack(spacing: 100) {
            ForEach(0..<3) { i in
                vm.currentImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: formatSize(value: 400, with: .width))
                    .position(
                        CGPoint(
                            x: vm.currentPosition.x,
                            y: vm.currentPosition.y - formatSize(value: 150 * Double(i), with: .height)
                        )
                    )
            }
        }
    }
}

