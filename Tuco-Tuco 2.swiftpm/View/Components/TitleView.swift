import SwiftUI

struct TitleView: View {
    var body: some View {
        Text("the TUCO-TUCO")
            .font(.custom(fontName, size: formatSize(value: 100, with: .width)))
            .foregroundStyle(.white)
            .position(CGPoint(x: UIScreen.main.bounds.width / 2, y: formatSize(value: 117, with: .height)))
    }
}

