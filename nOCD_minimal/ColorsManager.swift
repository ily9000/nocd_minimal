//
//  ColorManager.swift
//  nOCD_minimal
//
//  Created by Ilyas Patanam on 1/16/18.
//  Copyright © 2018 Ilyas Patanam. All rights reserved.
//

import Foundation
import UIKit

struct ColorsManager {
    static let salmon = UIColor(red: 255, green: 115, blue: 97)
    static let salmon1 = UIColor(red: 252, green: 243, blue: 136)
    static let salmon2 = UIColor(red: 252, green: 212, blue: 142)
    static let salmon3 = UIColor(red: 242, green: 63, blue: 93)
    static let salmon4 = UIColor(red: 255, green: 134, blue: 106)
    static let salmon5 = UIColor(red: 255, green: 134, blue: 106)
    static let salmon6 = UIColor(red: 255, green: 134, blue: 118)
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
