//
//  LastPlayedCollectionViewCell.swift
//  VoiceClub
//
//  Created by Bibin Jaimon on 20/03/20.
//  Copyright © 2020 Bibin Jaimon. All rights reserved.
//

import UIKit

class LastPlayedCollectionViewCell: UICollectionViewCell {
    static let cellID = "LastPlayedCollectionViewCell"
    @IBOutlet weak var lastPlayedAduioButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.lastPlayedAduioButton.layer.cornerRadius = (self.lastPlayedAduioButton.bounds.size.width / 2)
    }
    func setupCell(cornerRadius: CGFloat) {
        
    }
}
