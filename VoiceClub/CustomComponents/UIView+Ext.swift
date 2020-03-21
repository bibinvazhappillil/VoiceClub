//
//  UIView+Ext.swift
//  VoiceClub
//
//  Created by Bibin Jaimon on 22/03/20.
//  Copyright © 2020 Bibin Jaimon. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addTransparentBlackLayer(with opacity: Float) {
        let layer = CALayer()
        layer.backgroundColor = UIColor.black.cgColor
        layer.opacity = opacity
        layer.masksToBounds = false
        layer.frame = self.bounds
        self.layer.addSublayer(layer)
    }
    
    func bounce(scale: CGFloat) {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
        }) { (bool) in
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
            })
        }
    }
    func addShadowAndRoundCorner(cornerRadius : CGFloat = 6) {
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 5
        self.layer.shadowColor = VCColors.pausePlayButtonColor.cgColor
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
    }
}
