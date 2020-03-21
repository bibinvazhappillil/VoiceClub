//
//  Constants.swift
//  VoiceClub
//
//  Created by Bibin Jaimon on 20/03/20.
//  Copyright © 2020 Bibin Jaimon. All rights reserved.
//

import Foundation
import UIKit

enum VCColors {
    static var defaultPink: UIColor {
        return getColor(red: 255, green: 0, blue: 83)
    }
    
    static var pausePlayButtonColor: UIColor {
        return getColor(red: 255, green: 25, blue: 16)
    }
    
}
extension VCColors {
    static func getColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        let baseValue: CGFloat = 255.0
        return UIColor(red: red/baseValue, green: green/baseValue, blue: blue/baseValue, alpha: 1)
    }
}

class VCImages {
    static let pause = UIImage(named: "pause")
    static let play = UIImage(named: "play")
}
