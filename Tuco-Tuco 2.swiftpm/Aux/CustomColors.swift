import SwiftUI

enum CustomColor {
    case darkSand
    case dune0
    case dune1
    
    var color: Color {
        switch self {
        case .darkSand:
            return Color(hex: 0x5D3925)
        case .dune0:
            return Color(hex: 0xDAC285)
        case .dune1:
            return Color(hex: 0xD6BE80)
            
        }
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: alpha
        )
    }
}
