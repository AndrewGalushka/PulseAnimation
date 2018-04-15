//
//  UIColorRandomExtension.swift
//  Pulse
//
//  Created by admin on 4/14/18.
//  Copyright © 2018 Galushka. All rights reserved.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: CGFloat(arc4random() % 255) / 255.0,
                       green: CGFloat(arc4random() % 255) / 255.0,
                       blue: CGFloat(arc4random() % 255) / 255.0,
                       alpha: 1.0)
    }
}
