//
//  AudioListCollectionViewCell.swift
//  VoiceClub
//
//  Created by Bibin Jaimon on 20/03/20.
//  Copyright © 2020 Bibin Jaimon. All rights reserved.
//

import UIKit

class AudioListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var audioImageButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.audioImageButton.layer.cornerRadius = self.audioImageButton.bounds.size.height / 2
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.systemPink.cgColor
        self.layer.borderWidth = 1
    }
}
