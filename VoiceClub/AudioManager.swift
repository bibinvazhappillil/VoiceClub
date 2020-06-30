//
//  AudioManager.swift
//  VoiceClub
//
//  Created by Bibin Jaimon on 21/03/20.
//  Copyright © 2020 Bibin Jaimon. All rights reserved.
//

import Foundation
import AVFoundation

protocol AudioManagerDelegate {
    func audioPlayer(currentTimeText: String, currentTimeInSeconds: Double, totalTimeInSeconds: Double)
}

protocol AudioManagerDataSource {
    
}

class AudioManager {
    
    static var shared = AudioManager()
    
    var delegate: AudioManagerDelegate?
    
    var dataSource: AudioManagerDataSource?
    
    private var playerItem: AVPlayerItem!

    private var audioPlayer: AVPlayer?
    
    private var timeObserverToken: Any?
    
    private init() { }
    
    func playAudio(from fileURL: String) {

        if audioPlayer != nil {
            audioPlayer?.play()
            return
        }

        self.playerItem = AVPlayerItem(url: URL(fileURLWithPath: fileURL))
        self.audioPlayer = AVPlayer(playerItem: self.playerItem)
        self.audioPlayer?.playImmediately(atRate: 2.0)
        audioPlayer?.play()
        addPeriodicTimeObserver()
    }
    
    func increaseRate() {
        print("currentRate: \(self.audioPlayer?.rate)")
        self.audioPlayer?.rate += 0.5
    }
    
    func decreaseRate() {
        print("currentRate: \(self.audioPlayer?.rate)")
        self.audioPlayer?.rate -= 0.5
        
    }
    
    func pauseAudio() {
        self.audioPlayer?.pause()
    }
    
    func stopAudio() {
        self.audioPlayer?.pause()
        self.removePeriodicTimeObserver()
        self.audioPlayer = nil
    }
    
    private func addPeriodicTimeObserver() {
        // Notify every half second
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 1, preferredTimescale: timeScale)
        
        timeObserverToken = audioPlayer?.addPeriodicTimeObserver(forInterval: time, queue: .main) { [weak self] time in

            let totalTimeInSeconds: Double = self?.playerItem.duration.seconds ?? 0
            let currentTimeInSeconds: Double = self?.playerItem.currentTime().seconds ?? 0
            let remainingTime = totalTimeInSeconds - currentTimeInSeconds
            let durationText = self?.audioPlayer?.durationText(for: remainingTime) ?? ""
            
            self?.delegate?.audioPlayer(currentTimeText: durationText,
                                        currentTimeInSeconds: currentTimeInSeconds,
                                        totalTimeInSeconds: totalTimeInSeconds)
            
        }
    }

    private func removePeriodicTimeObserver() {
        if let timeObserverToken = timeObserverToken {
            audioPlayer?.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }
}
extension AVPlayer {
    
    func getFormattedString(_ number: Int) -> String {
        return number < 10 ? "0\(number)" : "\(number)"
    }
    
    func durationText(for seconds: Double) -> String {
        let seconds = Int(seconds)
        let hour = getFormattedString(seconds / 3600)
        let minute = getFormattedString((seconds % 3600) / 60)
        let second = getFormattedString((seconds % 3600) % 60)
        return "\(hour): \(minute): \(second)"
    }
}
