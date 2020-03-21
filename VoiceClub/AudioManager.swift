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
    func audioPlayer(currentTime: String)
}

class AudioManager {
    
    static var shared = AudioManager()
    
    var delegate: AudioManagerDelegate?
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
        audioPlayer?.play()
        addPeriodicTimeObserver()
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
//            print(time)
            self?.delegate?.audioPlayer(currentTime: self?.audioPlayer?.durationText() ?? "")
            
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
    func durationText() -> String {
        let seconds = Int(self.currentItem?.currentTime().seconds ?? 0)
        let hour = seconds / 3600
        let minute = (seconds % 3600) / 60
        let second = (seconds % 3600) % 60
        if hour == 0 {
            return "\(minute): \(second)"
        }
        return "\(hour): \(minute): \(second)"
    }
}
