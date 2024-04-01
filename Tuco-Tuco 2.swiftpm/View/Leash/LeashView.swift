//
//  LeashView.swift
//  My App
//
//  Created by Arthur Sobrosa on 24/02/24.
//

import SwiftUI

struct LeashView: View {
    @StateObject private var vm = LeashViewModel()
    @Binding var leashPositioned: Bool
    @Binding var isDigging: Bool
    
    var body: some View {
        Image("leash")
            .resizable()
            .scaledToFit()
            .frame(width: formatSize(value: 200, with: .width))
            .position(vm.currentPosition)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        vm.currentPosition = gesture.location
                    }
                    .onEnded { gesture in
                        vm.gestureLocation = gesture.location
                        
                        if vm.checkLeashPosition() {
                            leashPositioned = true
                            isDigging = false
                        }
                    }
            )
    }
}
