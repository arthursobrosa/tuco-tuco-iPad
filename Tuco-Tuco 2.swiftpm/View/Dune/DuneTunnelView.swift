import SwiftUI

struct DuneTunnelView: View {
    @StateObject private var vm = DuneTunnelViewModel()
    @StateObject private var vmGrass = AllGrassViewModel()
    
    @Binding var presentShakingView: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(vm.viewColor)
            
            if vm.showTunnel {
                TucoWalkingInDenView(presentStandingTuco: $vm.presentStandingTuco)
            }
            
            if vm.presentStandingTuco {
                TucoStandingView(isOutside: false, isTalking: $vm.isTalking, numberOfSqueaks: $vm.numberOfSqueaks)
                
                if vm.startSpeech {
                    TucoSpeechTextView(text: $vm.tucoSpeech, isOutside: false)
                }
            }
            
            if vm.showTucoShocked {
                TucoShockedView()
            }
            
            if vm.showHelpButton {
                Button {
                    vm.presentStandingTuco = false
                    vm.showHelpButton = false
                    vm.showGrass = true
                } label: {
                    ButtonView(title: "Sure!")
                }
                .position(CGPoint(x: formatSize(value: 1000, with: .width), y: formatSize(value: 300, with: .height)))
            }
            
            if vm.showGrass {
                ForEach(vm.allGrasses) { grassView in
                    grassView 
                }
                
                Text("Drag the grass towards Tuco to feed it")
                    .font(.custom(fontName, size: formatSize(value: 50, with: .width)))
                    .multilineTextAlignment(.center)
                    .frame(width: formatSize(value: 600, with: .width))
                    .foregroundStyle(.white)
                    .opacity(vm.helpTextOpacity)
                    .position(CGPoint(x: UIScreen.main.bounds.midX, y: formatSize(value: 50, with: .height)))
            }
        }
        .opacity(vmGrass.opacity)
        .onChange(of: vm.startView) { _, _ in
            withAnimation(Animation.linear(duration: 1.5)) {
                vm.changeColor()
                vm.showTunnel = true
            }
        }
        .onChange(of: vmGrass.makeItShake) { _, newValue in
            presentShakingView = newValue
        }
        .onChange(of: vm.showGrass) { _, _ in
            withAnimation(.linear(duration: 1).delay(2.5)) {
                vm.helpTextOpacity = 1.0 
            }
            
            vm.playGrassSound()
        }
        .environmentObject(vmGrass)
    }
}

