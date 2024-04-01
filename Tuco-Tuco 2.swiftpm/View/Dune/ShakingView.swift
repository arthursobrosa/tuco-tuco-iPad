import SwiftUI

struct ShakingView: View {
    @StateObject private var vm = ShakingViewModel()
    
    @Binding var presentBeachGoersView: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(CustomColor.dune0.color)
            
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .scaledToFit()
                    .frame(width: formatSize(value: 105, with: .width))
                    .foregroundStyle(CustomColor.darkSand.color)
                    .position(CGPoint(x: formatSize(value: 1055, with: .width), y: UIScreen.main.bounds.maxY))  
                
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundStyle(CustomColor.darkSand.color)
                
                TucoEscapingView()
                
                FallingSandView()
            }
            .rotationEffect(.degrees(vm.degrees))
            .onAppear {
                withAnimation(.linear(duration: 0.1).repeatForever(autoreverses: true)) {
                    vm.shakeIt()
                }
            }
            
            if vm.showTucoStanding {
                TucoStandingView(isOutside: false, isTalking: $vm.isTalking, numberOfSqueaks: $vm.numberOfSqueaks)
                
                if vm.startSpeech {
                    TucoSpeechTextView(text: $vm.tucoSpeech, isOutside: false)
                }
            }
            
            if vm.showHelpButton {
                Button {
                    vm.showTucoStanding = false
                    vm.startSpeech = false
                    vm.showHelpButton = false
                    vm.startTransition = true
                } label: {
                    ButtonView(title: "Help!")
                }
                .position(CGPoint(x: formatSize(value: 1000, with: .width), y: formatSize(value: 300, with: .height)))
            }
            
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.black)
                .opacity(vm.opacity)
        }
        .scaleEffect(vm.viewScale)
        .onChange(of: vm.startTransition) { _, _ in
            withAnimation(.linear(duration: 1)) {
                vm.changeView()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                vm.stopSound()
                presentBeachGoersView = true
            }
        }
    }
}

