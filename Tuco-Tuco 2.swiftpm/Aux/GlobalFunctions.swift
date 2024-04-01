import SwiftUI
import UIKit

enum Size {
    case width, height
}

func formatSize(value: CGFloat, with size: Size) -> CGFloat {
    switch size {
    case .width:
        return UIScreen.main.bounds.width * (value / 1194)
    case .height:
        return UIScreen.main.bounds.height * (value / 834)
    }
}

func addFont() {
    if let fontURL = Bundle.main.url(forResource: "Yomogi-Regular", withExtension: "ttf"),
       let fontData = try? Data(contentsOf: fontURL) as CFData, 
        let provider = CGDataProvider(data: fontData),
       let font = CGFont(provider) {
        CTFontManagerRegisterGraphicsFont(font, nil)
    }
}

let fontName = "Yomogi"
