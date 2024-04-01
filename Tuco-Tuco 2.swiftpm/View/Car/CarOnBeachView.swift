import SwiftUI

struct CarOnBeachView: View {
    @StateObject private var vm = CarOnBeachViewModel()
    @Binding var goToNextView: Bool
    
    var body: some View {
        ZStack {
            Image("duneTest")
                .resizable()
                .ignoresSafeArea()
            
            if vm.showTucoStanding {
                TucoStandingView(isOutside: false, isTalking: $vm.isTalking, numberOfSqueaks: $vm.numberOfSqueaks)
            }
            
            if vm.startSpeech {
                TucoSpeechTextView(text: $vm.tucoSpeech, isOutside: false)  
            }
            
            if vm.showOkButton {
                Button {
                    vm.showTucoStanding = false
                    vm.startSpeech = false
                    vm.showOkButton = false
                    vm.showCarView = true
                    vm.showSignView = true
                } label: {
                    ButtonView(title: "Ok ")
                }
                .position(CGPoint(x: formatSize(value: 1000, with: .width), y: formatSize(value: 300, with: .height)))
            }
            
            if vm.showSignView {
                SignView(isSignPositioned: $vm.isSignPositioned)
            }
            
            if vm.showCarView {
                CarView()
                
                Text("Drag the sign towards the sand strip to stop the car")
                    .font(.custom(fontName, size: formatSize(value: 50, with: .width)))
                    .multilineTextAlignment(.center)
                    .frame(width: formatSize(value: 700, with: .width))
                    .foregroundStyle(.white)
                    .opacity(vm.helpTextOpacity)
                    .position(CGPoint(x: UIScreen.main.bounds.midX, y: formatSize(value: 680, with: .height)))
            }
        }
        .onChange(of: vm.showCarView) { _, newValue in
            if !newValue {
                vm.stopSound()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    goToNextView = true
                }
            } else {
                vm.volumeUp() 
            }
        }
        .onChange(of: vm.isSignPositioned) { _, newValue in
            vm.showCarView = !newValue
        }
        .onChange(of: vm.showSignView) { _, _ in
            withAnimation(.linear(duration: 1).delay(1)) {
                vm.helpTextOpacity = 1.0
            }
        }
    }
}

