//
//  InfoView.swift
//  My App
//
//  Created by Arthur Sobrosa on 24/02/24.
//

import SwiftUI

struct InfoView: View {
    @State private var selection = 0
    @Binding var showInfoView: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    showInfoView = false
                } label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(width: formatSize(value: 50, with: .width))
                }
            }

            TabView(selection: $selection) {
                GeneralInfoView()
                    .tag(1)
                
                ProjectInfoView()
                    .tag(2)
            }
            .tabViewStyle(.page)
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width * 0.6)
        .background(Color.cyan.cornerRadius(20))
        .padding()
    }
}
