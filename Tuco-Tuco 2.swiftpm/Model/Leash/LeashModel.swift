//
//  LeashModel.swift
//  My App
//
//  Created by Arthur Sobrosa on 24/02/24.
//

import SwiftUI

struct LeashModel {
    static let originalPosition = CGPoint(x: UIScreen.main.bounds.midX, y: formatSize(value: 100, with: .height))
    
    
    static let rangeX: ClosedRange<CGFloat> = formatSize(value: 120, with: .width)...formatSize(value: 470, with: .width)
    static let rangeY: ClosedRange<CGFloat> = formatSize(value: 260, with: .height)...formatSize(value: 600, with: .height)
}
