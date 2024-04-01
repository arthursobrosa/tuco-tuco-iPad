import SwiftUI

struct MountView: View {
    @State private var mountOpacity = 0.0
    
    var body: some View {
        Image("mount")
            .resizable()
            .scaledToFit()
            .frame(width: formatSize(value: 300, with: .width))
            .opacity(mountOpacity)
            .position(CGPoint(x: formatSize(value: 950, with: .width), y: formatSize(value: 620, with: .height)))
            .onAppear {
                withAnimation(Animation.linear(duration: 2)) {
                    mountOpacity = 1.0
                }
            }
    }
}

