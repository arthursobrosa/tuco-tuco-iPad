//
//  InfoView.swift
//  My App
//
//  Created by Arthur Sobrosa on 24/02/24.
//

import SwiftUI

struct GeneralInfoView: View {
    let timer = Timer.publish(every: 0.2, on: .main, in: .default).autoconnect()
    
    @State private var count = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Image("tucoWalking" + "\(count % 3)")
                .resizable()
                .scaledToFit()
                .frame(height: formatSize(value: 120, with: .height))
            
            Text(InfoModel.generalInfoText)
                .font(.custom(fontName, size: formatSize(value: 31, with: .width)))
                .foregroundStyle(.white)
                .padding()
        }
        .onReceive(timer) { _ in
            count += 1
        }
    }
}
