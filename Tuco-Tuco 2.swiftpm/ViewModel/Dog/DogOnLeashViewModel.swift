//
//  DogOnLeashViewModel.swift
//  My App
//
//  Created by Arthur Sobrosa on 24/02/24.
//

import SwiftUI
import Combine

class DogOnLeashViewModel: ObservableObject {
    @Published var count = 0
    @Published var currentImage = Image("dogOnLeash0")
    
    @Published var currentPosition = DogOnLeashModel.initialPosition
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setTimer()
        setImage()
    }
    
    private func cancelAll() {
        cancellables.forEach { $0.cancel() }
    }
    
    private func setTimer() {
        Timer.publish(every: 0.2, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.count += 1
            }
            .store(in: &cancellables)
    }
    
    private func setImage() {
        $count
            .sink { [weak self] count in
                guard let self = self else { return }
                
                self.currentImage = Image("dogOnLeash" + "\(count % 4)")
            }
            .store(in: &cancellables)
    }
    
    public func move() {
        currentPosition = DogOnLeashModel.finalPosition
    }
}
