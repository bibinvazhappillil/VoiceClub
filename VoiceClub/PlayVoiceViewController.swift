//
//  PlayVoiceViewController.swift
//  VoiceClub
//
//  Created by Bibin Jaimon on 20/03/20.
//  Copyright © 2020 Bibin Jaimon. All rights reserved.
//

import UIKit
import AVFoundation

class PlayVoiceViewController: UIViewController {
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var audioPlayerBackgroundImageView: UIImageView!
    @IBOutlet weak var playAudioButton: PlayButton!
    
    var initialPlayButtonState: PlayButtonState! = .playing
    
    @IBOutlet weak var circularImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var circularImageView: UIImageView!
    
    private var transparentLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.black.cgColor
        layer.opacity = 0.7
        layer.masksToBounds = false
        return layer
    }()
    
    fileprivate func setupCircularImageView() {
        circularImageView.layer.cornerRadius = self.circularImageView.bounds.size.width / 2
        circularImageView.layer.masksToBounds = true
        circularImageView.addTransparentBlackLayer(with: 0.4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Eat That Frog"
        
        AudioManager.shared.delegate = self
        if initialPlayButtonState == .playing {
            playAudio()
        }
        
        setupPlayAudioButon()
        setupTransparentBalckLayer()
        
        setupCircularImageView()
        
        currentTimeLabel.textColor = VCColors.pausePlayButtonColor
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.transparentLayer.frame = self.view.bounds
        circularImageView.layer.cornerRadius = self.circularImageView.bounds.size.width / 2
    }
    
    fileprivate func setupPlayAudioButon() {
        self.playAudioButton.delegate   = self
        self.playAudioButton.dataSource = self
        self.playAudioButton.tintColor  = VCColors.pausePlayButtonColor
    }
    
    fileprivate func setupTransparentBalckLayer() {
        self.audioPlayerBackgroundImageView.layer.addSublayer(self.transparentLayer)
        self.transparentLayer.frame = self.view.bounds
    }

    
    func playAudio() {
        if let fileURL = Bundle.main.path(forResource: "audio", ofType: "mp3") {
            AudioManager.shared.playAudio(from: fileURL)
            print("Continue processing")
        } else {
            print("Error: No file with specified name exists")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        AudioManager.shared.stopAudio()
    }
    
}

extension PlayVoiceViewController: AudioManagerDelegate {
    func audioPlayer(currentTime: String) {
        self.currentTimeLabel.text = "\(currentTime)"
    }
}

extension PlayVoiceViewController: PlayButtonDelegate {
    func playButton(playButton: PlayButton, didTappedWith tag: Int, status: PlayButtonState) {
        switch status {
        case .playing:
            playAudio()
        case .paused:
            AudioManager.shared.pauseAudio()
        }
        self.circularImageView.bounce(scale: 1.1)
    }
}

extension PlayVoiceViewController: PlayButtonDataSource {
    
    func initialState(for playButton: PlayButton) -> PlayButtonState {
        return self.initialPlayButtonState
    }

    func playButton(playButton: PlayButton, playImageFor tag: Int) -> UIImage? {
        return VCImages.play
    }
    
    func playButton(playButton: PlayButton, pausedImageFor tag: Int) -> UIImage? {
        return VCImages.pause
    }
}
