//
//  DogDiggingView.swift
//  My App
//
//  Created by Arthur Sobrosa on 24/02/24.
//

import SwiftUI

struct DogDiggingView: View {
    @StateObject private var vm = DogDiggingViewModel()
    
    var body: some View {
        vm.currentImage
            .resizable()
            .scaledToFit()
            .frame(width: formatSize(value: 180, with: .width))
            .position(DogModel.diggingPosition)
    }
}
