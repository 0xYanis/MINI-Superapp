//
//  UITextField+Extension.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit

extension UITextField {
    convenience init(label: String, borderColor: UIColor = .systemCyan, cornerRadius: Double = 10, fontSize: CGFloat = 18, height: CGFloat, width: CGFloat) {
        self.init(frame: .zero)
        self.roundCorners(radius: cornerRadius)
        self.backgroundColor = .white
        self.layer.borderColor = borderColor.cgColor
        self.font = .systemFont(ofSize: fontSize)
    }
}
