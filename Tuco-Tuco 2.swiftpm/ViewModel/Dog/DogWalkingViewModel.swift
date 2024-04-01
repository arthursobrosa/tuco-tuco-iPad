//
//  DogWalkingViewModel.swift
//  My App
//
//  Created by Arthur Sobrosa on 24/02/24.
//

import SwiftUI
import Combine

class DogWalkingViewModel: ObservableObject {
    @Published var count = 0
    @Published var currentImage = Image("dogWalking0")
    @Published var currentPosition = DogModel.initialWalkPosition
    @Published var isWalking = true
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setTimer()
        setImage()
        stopWalking()
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
                
                self.currentImage = Image("dogWalking" + "\(count % 2)")
            }
            .store(in: &cancellables)
    }
    
    public func changePosition() {
        currentPosition = DogModel.finalWalkPosition
    }
    
    private func stopWalking() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            guard let self = self else { return }
            
            self.cancelAll()
            self.isWalking = false
        }
    }
}
