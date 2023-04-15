//
//  UILabel+Extension.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1, color: CIColor) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = UIColor(ciColor: color)
        self.numberOfLines = numberOfLines
    }
}
