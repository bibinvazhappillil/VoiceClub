//
//  PlayButton.swift
//  VoiceClub
//
//  Created by Bibin Jaimon on 21/03/20.
//  Copyright © 2020 Bibin Jaimon. All rights reserved.
//

import Foundation
import UIKit

class PlayButton: UIButton {
    
    private var playButtonState: PlayButtonState = .playing
    private var initialPlayButtonState: PlayButtonState?
    
    var delegate: PlayButtonDelegate?
    var dataSource: PlayButtonDataSource?
    var currentState: PlayButtonState {
        get {
            return self.playButtonState
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addTarget(self, action: #selector(didTappedMe(sender:)), for: .touchUpInside)
        
    }
    
    private func togglePlayButtonState() {
        switch self.playButtonState {
        case .playing:
            self.playButtonState = .paused
            let image = dataSource?.playButton(playButton: self, playImageFor: self.tag)
            self.setButtonImage(image: image)
        case .paused:
            self.playButtonState = .playing
            let image = dataSource?.playButton(playButton: self, pausedImageFor: self.tag)
            setButtonImage(image: image)
        }
    }
    
    private func setButtonImage(image: UIImage?) {
        self.setImage(image, for: .normal)
    }
    
    @objc func didTappedMe(sender: PlayButton) {
        self.togglePlayButtonState()
        delegate?.playButton(playButton: sender, didTappedWith: sender.tag, status: self.playButtonState)
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
//        print("draw()")
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
//        print("setNeedsLayout")
    }
    
    private func setupInitialButtonBehaviour() {
        if let initialState = dataSource?.initialState(for: self) {
            if self.initialPlayButtonState == nil {
                self.initialPlayButtonState = initialState
                self.playButtonState = initialState
                switch initialState {
                case .playing:
                    let image = dataSource?.playButton(playButton: self, pausedImageFor: self.tag)
                    setButtonImage(image: image)
                case .paused:
                    let image = dataSource?.playButton(playButton: self, playImageFor: self.tag)
                    setButtonImage(image: image)
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupInitialButtonBehaviour()
    }
}

public enum PlayButtonState {
    case paused
    case playing
}
protocol PlayButtonDelegate {
    func playButton(playButton: PlayButton, didTappedWith tag: Int, status: PlayButtonState)
}

protocol PlayButtonDataSource {
    func initialState(for playButton: PlayButton) -> PlayButtonState
    func playButton(playButton: PlayButton, playImageFor tag: Int) -> UIImage?
    func playButton(playButton: PlayButton, pausedImageFor tag: Int) -> UIImage?
}
extension PlayButtonDataSource {
    //NOTE:- Default Value
    func initialState(for playButton: PlayButton) -> PlayButtonState {
        return PlayButtonState.playing
    }
}
