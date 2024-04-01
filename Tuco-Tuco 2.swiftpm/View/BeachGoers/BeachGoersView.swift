import SwiftUI

struct BeachGoersView: View {
    @StateObject private var vmFence = AllFencesViewModel()
    @StateObject private var vm = BeachGoersViewModel()
    
    @Binding var goToNextView: Bool
    
    var body: some View {
        ZStack {
            vm.currentImage
                .resizable()
                .ignoresSafeArea()
            
            if vm.showTucoScaredView {
                TucoScaredView(tucoHasDisappeared: $vm.tucoScaredHasDisappeared)
            } 
            
            if vm.showTucoStandingView {
                TucoStandingView(isOutside: false, isTalking: $vm.isTalking, numberOfSqueaks: $vm.numberOfSqueaks)
            }
            
            if vm.showTucoSpeech {
                TucoSpeechTextView(text: $vm.tucoSpeech, isOutside: false)
            } 
            
            if vm.showHelpButton {
                Button {
                    vm.showTucoStandingView = false
                    vm.showTucoSpeech = false
                    vm.showHelpButton = false
                    vm.showDraggableFences = true
                } label: {
                    ButtonView(title: "Ok!")
                }
                .position(CGPoint(x: formatSize(value: 1000, with: .width), y: formatSize(value: 300, with: .height)))
            }
            
            if vm.showDraggableFences {
                ForEach(vm.allFences) { fenceView in
                    fenceView
                } 
                
                Text("Drag the barriers to the left dune to isolate the area")
                    .font(.custom(fontName, size: formatSize(value: 40, with: .width)))
                    .multilineTextAlignment(.center)
                    .frame(width: formatSize(value: 720, with: .width))
                    .foregroundStyle(.white)
                    .opacity(vm.helpTextOpacity)
                    .position(CGPoint(x: formatSize(value: 800, with: .width), y: formatSize(value: 60, with: .height)))
            }
            
            if vmFence.showFirstFence {
                FenceView(vm: FenceViewModel(fenceIndex: 0))
            }
            
            if vmFence.showSecondFence {
                FenceView(vm: FenceViewModel(fenceIndex: 1))
            }
            
            if !vmFence.arePeopleOverDune {
                GuysLeavingView()
            }
            
            Rectangle()
                .foregroundStyle(.black)
                .ignoresSafeArea()
                .opacity(vm.opacity)
        }
        .onChange(of: vm.startPresentation) { _, newValue in
            if newValue {
                withAnimation(.linear(duration: 1)) {
                    vm.changeOpacity()
                }
            }
        }
        .onChange(of: vmFence.arePeopleOverDune) { _, newValue in
            vm.arePeopleOverDune = newValue
            
            if !newValue {
                vm.showDraggableFences = false
            }
        }
        .onChange(of: vm.goToNextView) { _, newValue in 
            goToNextView = newValue
        }
        .onChange(of: vm.showDraggableFences) { _, _ in
            withAnimation(.linear(duration: 1).delay(1)) {
                vm.helpTextOpacity = 1.0  
            }
        }
        .environmentObject(vmFence)
    }
}

