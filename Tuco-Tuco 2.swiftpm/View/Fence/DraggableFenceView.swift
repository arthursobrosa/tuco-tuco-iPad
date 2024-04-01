import SwiftUI

struct DraggableFenceView: View, Identifiable {
    let id = UUID()
    
    @StateObject var vm: DraggableFenceViewModel
    @EnvironmentObject var vmFence: AllFencesViewModel
    
    var body: some View {
        Image("fence0")
            .resizable()
            .scaledToFit()
            .frame(width: FenceModel.draggableFenceWidth)
            .opacity(vm.fenceOpacity)
            .position(vm.fencePosition)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if vm.isDraggable {
                            vm.fencePosition = gesture.location
                        }
                    }
                    .onEnded { gesture in
                        if vm.isDraggable {
                            vm.gestureLocation = gesture.location
                            
                            if vm.checkFencePosition() {
                                vmFence.numberOfFences += 1
                                vm.isDraggable = false
                            }
                        }
                    }
            )
    }
}

