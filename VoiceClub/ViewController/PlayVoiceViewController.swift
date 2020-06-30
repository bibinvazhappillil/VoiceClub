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
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    var initialPlayButtonState: PlayButtonState! = .playing
    var circularImageViewProgressBar: CircularProgressView?
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
        circularImageView.addTransparentBlackLayer(with: 0.6)
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
        currentTimeLabel.textColor = .white
        currentTimeLabel.text = "00: 00: 00"
        
        addCircularProgressBar()
        setupTintColors()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.transparentLayer.frame = self.view.bounds
        circularImageView.layer.cornerRadius = self.circularImageView.bounds.size.width / 2
    }
    
    private func setupTintColors() {
        self.playAudioButton.tintColor = VCColors.pausePlayButtonColor
        self.minusButton.tintColor = .white
        self.plusButton.tintColor = .white
    }
    
    fileprivate func addCircularProgressBar() {
        self.circularImageViewProgressBar = CircularProgressView(layerBounds: self.circularImageView.bounds)
        self.circularImageView.layer.addSublayer(self.circularImageViewProgressBar!)
        self.circularImageViewProgressBar?.dataSource = self
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
    
    @IBAction func didTappedSpeedMinusButton(_ sender: UIButton) {
        AudioManager.shared.decreaseRate()
    }
    
    @IBAction func didTappedSpeedPlusButton(_ sender: UIButton) {
        AudioManager.shared.increaseRate()
    }
    
}

extension PlayVoiceViewController: AudioManagerDelegate {
    
    func audioPlayer(currentTimeText: String, currentTimeInSeconds: Double, totalTimeInSeconds: Double) {
        self.currentTimeLabel.text = "\(currentTimeText)"
        let currentStroke: CGFloat = CGFloat(currentTimeInSeconds / totalTimeInSeconds)
        self.circularImageViewProgressBar?.setProgress(to: currentStroke)
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

extension PlayVoiceViewController: CircularProgressViewDataSource {
    func progressView(trackColorFor tag: Int) -> UIColor {
        return VCColors.pausePlayButtonColor
    }
    
    func progressView(progressFillColorFor tag: Int) -> UIColor {
        return VCColors.circularTrackColor
    }
    
    func progressView(trackRadiusFor tag: Int) -> CGFloat {
        return self.circularImageView.bounds.width / 2
    }
    
    func progressView(trackWidthFor tag: Int) -> CGFloat {
        return 5
    }
}
