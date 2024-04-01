//
//  LeashViewModel.swift
//  My App
//
//  Created by Arthur Sobrosa on 24/02/24.
//

import SwiftUI

class LeashViewModel: ObservableObject {
    @Published var currentPosition = LeashModel.originalPosition
    @Published var gestureLocation = CGPoint()
    
    public func checkLeashPosition() -> Bool {
        if LeashModel.rangeX.contains(gestureLocation.x) && LeashModel.rangeY.contains(gestureLocation.y) {
            currentPosition = gestureLocation
            
            return true
        } else {
            currentPosition = LeashModel.originalPosition
            
            return false
        }
    }
}
