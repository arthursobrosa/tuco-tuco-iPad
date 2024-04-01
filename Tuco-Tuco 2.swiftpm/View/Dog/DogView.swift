//
//  DogView.swift
//  My App
//
//  Created by Arthur Sobrosa on 24/02/24.
//

import SwiftUI

struct DogView: View {
    @StateObject private var vm = DogViewModel() 
    @Binding var goToNextView: Bool
    
    var body: some View { 
        ZStack {
            Image("duneTest")
                .resizable()
                .ignoresSafeArea()
            
            if vm.showDogWalking {
                DogWalkingView(isWalking: $vm.showDogWalking, startDigging: $vm.showDogDigging) 
            }
            
            if vm.showDogDigging {
                DogDiggingView()
            }
            
            if vm.showLeash {
                LeashView(leashPositioned: $vm.showDogOnLeash, isDigging: $vm.showDogDigging)
                    .opacity(vm.leashOpacity)
                
                Text("Drag the leash towards the dog")
                    .font(.custom(fontName, size: formatSize(value: 40, with: .width)))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: formatSize(value: 500, with: .width))
                    .opacity(vm.leashOpacity)
                    .position(CGPoint(x: UIScreen.main.bounds.maxX - formatSize(value: 260, with: .width), y: formatSize(value: 70, with: .height)))
            }
            
            if vm.showDogOnLeash {
                DogOnLeashView(showDogView: $vm.showDogView)
            }
            
            if vm.showTucoStanding {
                TucoStandingView(isOutside: false, isTalking: $vm.isTalking, numberOfSqueaks: $vm.numberOfSqueaks)
            }
            
            if vm.showSpeech {
                TucoSpeechTextView(text: $vm.tucoSpeech, isOutside: false)
            }
            
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.black)
                .opacity(vm.viewOpacity)
        }
        .onChange(of: vm.showDogOnLeash) { _, newValue in
            vm.platCorrectAudio()
            vm.showLeash = !newValue
        }
        .onChange(of: vm.showLeash) { _, newValue in
            withAnimation(.linear(duration: 1).delay(2)) {
                vm.changeLeashOpacity()
            }
        }
        .onChange(of: vm.showDogView) { _, newValue in
            withAnimation(.linear(duration: 1).delay(1)) {
                vm.makeTransition()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                goToNextView = true
            }
        }
    }
}
