//
//  UILabel+Extension.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1, color: UIColor?) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = color
        self.numberOfLines = numberOfLines
    }
    
    func setCustomAppearance() {
        self.font = .boldSystemFont(ofSize: 20)
        self.numberOfLines = 1
        self.textColor = .front2MINI
    }
    
}
