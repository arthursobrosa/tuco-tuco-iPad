import SwiftUI

struct BeachView: View {
    @StateObject private var vm = BeachViewModel()
    
    @Binding var presentDuneTunnelView: Bool
    
    var body: some View {
        ZStack {
            OceanView(isPlaying: $vm.isPlayingBeachSounds)
            DuneView()
            QueroView(isPlaying: $vm.isPlayingBeachSounds)
            
            if !vm.playButtonClicked {
                TucoLargeView()
                
                TitleView()
                
                Button {
                    vm.playButtonClicked = true
                } label: {
                    ButtonView(title: "Play")
                }
                .position(CGPoint(x: formatSize(value: 150, with: .width), y: formatSize(value: 700, with: .height)))
                
                Text("Run it on landscape mode for a better experience")
                    .font(.custom(fontName, size: formatSize(value: 35, with: .width)))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .position(CGPoint(x: UIScreen.main.bounds.midX + formatSize(value: 150, with: .width), y: formatSize(value: 760, with: .height)))
            }
            
            if vm.startPresentation {
                TucoStandingView(isOutside: true, isTalking: $vm.isTalking, numberOfSqueaks: $vm.numberOfSqueaks)
                
                if vm.startSpeech {
                    TucoSpeechTextView(text: $vm.speechText, isOutside: true)
                }
                
                if vm.showMap {
                    BrazilView()
                }
                
                if vm.showGoInsideButton {
                    Button {
                        vm.startPresentation = false
                        vm.goInside = true
                    } label: {
                        ButtonView(title: "Yes!")
                    }
                    .position(CGPoint(x: formatSize(value: 1000, with: .width), y: formatSize(value: 300, with: .height)))
                }
            }
            
            if vm.goInside {
                TucoEnteringDenView(goToNextPage: $vm.goToNextPage)
            }
            
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.black)
                .opacity(vm.viewOpacity)
        }
        .scaleEffect(vm.viewScale)
        .position(vm.viewPosition)
        .onChange(of: vm.goToNextPage) { _, newValue in
            withAnimation(Animation.linear(duration: 2)) {
                vm.changeViewLooks()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                presentDuneTunnelView = newValue
                vm.isPlayingBeachSounds = false  
            }
        }
    }
}

