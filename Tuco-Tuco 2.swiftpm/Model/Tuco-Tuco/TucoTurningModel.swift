import SwiftUI

enum TurningFrame: String, CaseIterable {
    case tucoTurning0, tucoTurning1, tucoTurning2, tucoTurning3, tucoTurning4, tucoTurning5, tucoTurning6
    
    var size: CGSize {
        switch self {
        case .tucoTurning0:
            return CGSize(width: formatSize(value: 929, with: .width), height: formatSize(value: 500, with: .height))
        case .tucoTurning1:
            return CGSize(width: formatSize(value: 917, with: .width), height: formatSize(value: 539, with: .height))
        case .tucoTurning2:
            return CGSize(width: formatSize(value: 753, with: .width), height: formatSize(value: 539, with: .height))
        case .tucoTurning3:
            return CGSize(width: formatSize(value: 564, with: .width), height: formatSize(value: 633, with: .height))
        case .tucoTurning4:
            return CGSize(width: formatSize(value: 564, with: .width), height: formatSize(value: 634, with: .height))
        case .tucoTurning5:
            return CGSize(width: formatSize(value: 564, with: .width), height: formatSize(value: 633, with: .height))
        case .tucoTurning6:
            return CGSize(width: formatSize(value: 753, with: .width), height: formatSize(value: 539, with: .height))
        }
    }
    
    var scale: CGFloat {
        switch self {
        case .tucoTurning0:
            return 1.0
        case .tucoTurning1:
            return 0.8
        case .tucoTurning2:
            return 0.5
        case .tucoTurning3:
            return 0.3
        case .tucoTurning4:
            return 0.3
        case .tucoTurning5:
            return 0.3
        case .tucoTurning6:
            return 0.3
        }
    }
    
    var position: CGPoint {
        switch self {
        case .tucoTurning0:
            return CGPoint(x: formatSize(value: 747, with: .width), y: formatSize(value: 597, with: .height))
        case .tucoTurning1:
            return CGPoint(x: formatSize(value: 650, with: .width), y: formatSize(value: 700, with: .height))
        case .tucoTurning2:
            return CGPoint(x: formatSize(value: 600, with: .width), y: formatSize(value: 700, with: .height))
        case .tucoTurning3:
            return CGPoint(x: formatSize(value: 550, with: .width), y: formatSize(value: 700, with: .height))
        case .tucoTurning4:
            return CGPoint(x: formatSize(value: 550, with: .width), y: formatSize(value: 675, with: .height))
        case .tucoTurning5:
            return CGPoint(x: formatSize(value: 550, with: .width), y: formatSize(value: 650, with: .height))
        case .tucoTurning6:
            return CGPoint(x: formatSize(value: 700, with: .width), y: formatSize(value: 625, with: .height))
        }
    }
}

