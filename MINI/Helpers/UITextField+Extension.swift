//
//  UITextField+Extension.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit
import SnapKit

extension UITextField {
    convenience init(label: String, borderColor: UIColor = .systemCyan, cornerRadius: Double = 10, fontSize: CGFloat = 18) {
        self.init(frame: .zero)
        self.roundCorners(radius: cornerRadius)
        self.backgroundColor = .red
        self.layer.borderColor = borderColor.cgColor
        self.font = .systemFont(ofSize: fontSize)
    }
}
