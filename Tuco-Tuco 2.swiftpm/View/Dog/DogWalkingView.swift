//
//  DogWalkingView.swift
//  My App
//
//  Created by Arthur Sobrosa on 24/02/24.
//

import SwiftUI

struct DogWalkingView: View {
    @StateObject private var vm = DogWalkingViewModel()
    @Binding var isWalking: Bool
    @Binding var startDigging: Bool
    
    var body: some View {
        vm.currentImage
            .resizable()
            .scaledToFit()
            .frame(width: formatSize(value: 200, with: .width))
            .position(vm.currentPosition)
            .onAppear {
                withAnimation(.linear(duration: 4)) {
                    vm.changePosition()
                }
            }
            .onChange(of: vm.isWalking) { _, newValue in
                isWalking = newValue
                startDigging = !newValue
            }
    }
}
