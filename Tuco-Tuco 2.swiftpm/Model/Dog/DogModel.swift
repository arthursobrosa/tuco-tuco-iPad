//
//  DogModel.swift
//  My App
//
//  Created by Arthur Sobrosa on 24/02/24.
//

import SwiftUI

struct DogModel {
    static let initialWalkPosition = CGPoint(x: UIScreen.main.bounds.maxX + formatSize(value: 100, with: .width), y: UIScreen.main.bounds.midY + formatSize(value: 300, with: .height))
    static let finalWalkPosition = CGPoint(x: formatSize(value: 300, with: .width), y: initialWalkPosition.y - formatSize(value: 250, with: .height))
    
    
    static let diggingPosition = CGPoint(x: finalWalkPosition.x - formatSize(value: 10, with: .width), y: finalWalkPosition.y - formatSize(value: 25, with: .height))
}
