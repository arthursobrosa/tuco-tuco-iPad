import SwiftUI

struct GrassView: View, Identifiable {
    let id = UUID()
    
    @StateObject var vm: GrassViewModel
    @EnvironmentObject var vmGrass: AllGrassViewModel
    
    var body: some View {
        if vm.showGrass {
            Image("grass")
                .resizable()
                .scaledToFit()
                .frame(width: vm.currentWidth)
                .scaleEffect(vm.scale)
                .opacity(vm.opacity)
                .position(vm.currentPosition)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if vmGrass.lastGrass {
                                vmGrass.makeItShake = true
                            } else {
                                vm.currentPosition = gesture.location
                            }
                        }
                        .onEnded { gesture in
                            vm.gestureLocation = gesture.location
                            
                            if vm.checkGrassPosition() {
                                withAnimation(Animation.linear(duration: 0.2)) {
                                    vmGrass.numberOfGrass += 1
                                    vm.eatGrass()
                                    vm.playSound()
                                }
                            }
                        }
                )
        }
    }
}

