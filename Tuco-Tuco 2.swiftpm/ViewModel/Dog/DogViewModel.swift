//
//  DogViewModel.swift
//  My App
//
//  Created by Arthur Sobrosa on 24/02/24.
//

import SwiftUI
import Combine
import AVFoundation

class DogViewModel: ObservableObject {
    @Published var showTucoStanding = true
    @Published var isTalking = false
    @Published var numberOfSqueaks = TextAndSqueaks.dogSqueaks[0]
    @Published var showSpeech = false
    @Published var tucoSpeech = TextAndSqueaks.dogTexts[0]
    private let chronologyDelays = [0.5, 2.0, 4.0, 7.0]
    
    @Published var showDogWalking = false
    @Published var showDogDigging = false
    @Published var showLeash = false
    @Published var showDogOnLeash = false
    
    @Published var leashOpacity = 0.0
    
    @Published var showDogView = true
    @Published var viewOpacity = 0.0
    
    private var barkAudioPlayer: AVAudioPlayer? = nil
    private var correctAudioPlayer: AVAudioPlayer? = nil
    
    
    private var showLeashPublisher: AnyCancellable?
    private var barkingPublisher: AnyCancellable?
    
    init() {
        delayAndStartTalking()
        startChronology()
        setShowLeash()
        setAudios()
    }
    
    private func setAudios() {
        do {
            let audio = try AudioService(soundCase: .bark).getSound()
            audio.numberOfLoops = -1
            barkAudioPlayer = audio
        } catch let error {
            print("Error: \(error)")
        }
        
        do {
            let audio = try AudioService(soundCase: .correct).getSound()
            audio.numberOfLoops = 0
            correctAudioPlayer = audio
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    private func setBarking() {
        barkingPublisher = $showDogWalking
            .sink { [weak self] value in
                guard let self = self else { return }
                
                if !value {
                    self.stopBarkAudio()
                    self.barkingPublisher?.cancel()
                }
            }
    }
    
    private func playBarkAudio() {
        barkAudioPlayer?.play()
    }
    
    private func stopBarkAudio() {
        barkAudioPlayer?.stop()
    }
    
    public func platCorrectAudio() {
        correctAudioPlayer?.play()
    }
    
    private func delayAndStartTalking() {
        DispatchQueue.main.asyncAfter(deadline: .now() + chronologyDelays[0]) { [weak self] in
            guard let self = self else { return }
            
            self.isTalking = true
            self.showSpeech = true
        }
    }
    
    private func startChronology() {
        for i in 0..<chronologyDelays.count - 1 {
            makeDelay(of: chronologyDelays[i + 1], with: i + 1)
        }
    }
    
    private func makeDelay(of delay: Double, with speechIndex: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }
            
            self.isTalking = true
            self.numberOfSqueaks = TextAndSqueaks.dogSqueaks[speechIndex]
            self.tucoSpeech = TextAndSqueaks.dogTexts[speechIndex]
            
            if speechIndex == 3 {
                self.showDogWalking = true
                self.playBarkAudio()
                self.setBarking()
                self.hideTucoAndSpeech()
            }
        }
    }
    
    private func hideTucoAndSpeech() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [weak self] in
            guard let self = self else { return }
            
            self.showTucoStanding = false
            self.showSpeech = false
        }
    }
    
    private func setShowLeash() {
        showLeashPublisher = $showDogDigging
            .sink { [weak self] value in
                guard let self = self else { return }
                
                if value {
                    self.showLeash = true
                    showLeashPublisher?.cancel()
                }
            }
    }
    
    public func changeLeashOpacity() {
        leashOpacity = 1.0
    }
    
    public func makeTransition() {
        viewOpacity = 1.0
    }
}
