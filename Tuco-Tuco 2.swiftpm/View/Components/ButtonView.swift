import SwiftUI

struct ButtonView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.custom(fontName, size: formatSize(value: 70, with: .width)))
            .foregroundStyle(.white)
            .padding()
            .padding(.bottom)
            .padding(.horizontal)
            .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.blue))
    }
}

