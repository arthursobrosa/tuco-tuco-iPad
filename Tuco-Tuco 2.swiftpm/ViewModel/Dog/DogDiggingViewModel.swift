//
//  DogDiggingViewModel.swift
//  My App
//
//  Created by Arthur Sobrosa on 24/02/24.
//

import SwiftUI
import Combine
import AVFoundation

class DogDiggingViewModel: ObservableObject {
    @Published var count = 0
    @Published var currentImage = Image("dogDigging0")
    
    private var audioPlayer: AVAudioPlayer? = nil
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setTimer()
        setImage()
        setAudio()
    }
    
    private func cancelAll() {
        cancellables.forEach { $0.cancel() }
    }
    
    private func setAudio() {
        do {
            let audio = try AudioService(soundCase: .throwSand).getSound()
            audio.numberOfLoops = -1
            audioPlayer = audio
            audioPlayer?.play()
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    public func stopAudio() {
        audioPlayer?.stop()
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
                
                self.currentImage = Image("dogDigging" + "\(count % 2)")
            }
            .store(in: &cancellables)
    }
}
