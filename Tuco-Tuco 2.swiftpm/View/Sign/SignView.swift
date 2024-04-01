import SwiftUI

struct SignView: View {
    @StateObject private var vm = SignViewModel()
    @Binding var isSignPositioned: Bool
    
    var body: some View {
        Image("sign")
            .resizable()
            .scaledToFit()
            .frame(width: SignModel.draggableSignWidth)
            .position(vm.signPosition)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if vm.isDraggable {
                            vm.signPosition = gesture.location
                        }
                    }
                    .onEnded { gesture in
                        if vm.isDraggable {
                            vm.gestureLocation = gesture.location
                            
                            if vm.checkFencePosition() {
                                vm.playSound()
                                vm.isDraggable = false
                                isSignPositioned = true
                            }
                        }
                    }
            )
    }
}

