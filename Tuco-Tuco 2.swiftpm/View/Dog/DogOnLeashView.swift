//
//  DogOnLeashView.swift
//  My App
//
//  Created by Arthur Sobrosa on 24/02/24.
//

import SwiftUI

struct DogOnLeashView: View {
    @StateObject private var vm = DogOnLeashViewModel()
    @Binding var showDogView: Bool
    
    var body: some View {
        vm.currentImage
            .resizable()
            .scaledToFit()
            .frame(width: formatSize(value: 340, with: .width))
            .position(vm.currentPosition)
            .onAppear {
                withAnimation(.linear(duration: 2)) {
                    vm.move()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showDogView = false
                }
            }
    }
}
