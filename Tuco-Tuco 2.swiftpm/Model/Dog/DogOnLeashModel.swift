//
//  DogOnLeashModel.swift
//  My App
//
//  Created by Arthur Sobrosa on 24/02/24.
//

import SwiftUI

struct DogOnLeashModel {
    static let initialPosition = CGPoint(x: formatSize(value: 350, with: .width), y: formatSize(value: 500, with: .height))
    static let finalPosition = CGPoint(x: formatSize(value: -200, with: .width), y: initialPosition.y)
}
