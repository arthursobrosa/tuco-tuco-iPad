//
//  ProjectInfoView.swift
//  My App
//
//  Created by Arthur Sobrosa on 24/02/24.
//

import SwiftUI

struct ProjectInfoView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image("project")
                .resizable()
                .scaledToFit()
                .frame(width: formatSize(value: 200, with: .width))
            
            Spacer()
            
            Text(InfoModel.projectInfoText)
                .font(.custom(fontName, size: formatSize(value: 31, with: .width)))
                .foregroundStyle(.white)
                .padding()
            
            Spacer()
        }
    }
}
