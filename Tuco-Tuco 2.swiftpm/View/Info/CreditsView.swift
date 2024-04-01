//
//  CreditsView.swift
//  My App
//
//  Created by Arthur Sobrosa on 24/02/24.
//

import SwiftUI

struct CreditsView: View {
    @Binding var showCreditsView: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    showCreditsView = false
                } label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(width: formatSize(value: 50, with: .width))
                }
            }
            
            Image("arthur")
                .resizable()
                .scaledToFit()
                .frame(width: formatSize(value: 200, with: .width))
            
            Text(CreditsModel.bioText)
                .font(.custom(fontName, size: formatSize(value: 31, with: .width)))
                .foregroundStyle(.white)
                .padding()
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width * 0.6)
        .background(Color.cyan.cornerRadius(20))
        .padding()
    }
}
