import SwiftUI

struct LastScreenView: View {
    @StateObject private var vm = LastScreenViewModel()
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.black)
                .opacity(vm.backgroundOpacity)
            
            OceanView(isPlaying: $vm.isPlayingWaveSound)
            DuneView()
            
            if vm.showStandingTuco {
                TucoStandingView(isOutside: true, isTalking: $vm.isTalking, numberOfSqueaks: $vm.numberOfSqueaks) 
            }
            
            if vm.showSpeech {
                TucoSpeechTextView(text: $vm.tucoSpeech, isOutside: true)
                    .position(CGPoint(x: UIScreen.main.bounds.midX, y: formatSize(value: 430, with: .height)))
            }
            
            if vm.showPeaceTuco {
                TucoPeaceView()
                
                Text("PEACE!")
                    .font(.custom(fontName, size: formatSize(value: 100, with: .width)))
                    .foregroundStyle(.white)
                    .position(CGPoint(x: UIScreen.main.bounds.midX, y: formatSize(value: 100, with: .height)))
            }
            
            if vm.showLastButtons {
                HStack(spacing: 50) {
                    Button {
                        vm.showCreditsView = true
                    } label: {
                        ButtonView(title: "Credits")
                    }
                    
                    Button {
                        vm.showInfoView = true
                    } label: {
                        ButtonView(title: "Info   ")
                    }
                }
                .opacity(vm.lastButtonsOpacity)
            }
            
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.black) 
                .opacity(vm.viewOpacity)
            
            if vm.showCreditsView {
                CreditsView(showCreditsView: $vm.showCreditsView)
            }
            
            if vm.showInfoView {
                InfoView(showInfoView: $vm.showInfoView)
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 1)) {
                vm.changeViewOpacity()
            }
        }
        .onChange(of: vm.showLastButtons) { _, newValue in
            withAnimation(.linear(duration: 2).delay(1.5)) {
                vm.changeLastButtonsOpacity()
            }
        }
        .onChange(of: vm.showInfoView) { _, newValue in
            if newValue {
                vm.viewOpacity = 0.7
            } else {
                vm.viewOpacity = 0.0
            }
        }
        .onChange(of: vm.showCreditsView) { _, newValue in
            if newValue {
                vm.viewOpacity = 0.7
            } else {
                vm.viewOpacity = 0.0
            }
        }
    }
}

