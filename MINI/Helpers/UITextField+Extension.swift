//
//  UITextField+Extension.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit
import SnapKit

extension UITextField {
    func setCustomAppearance(withBorderColor borderColor: UIColor, cornerRadius: CGFloat, padding: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 1
        layer.borderColor = borderColor.cgColor
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        let rightPaddingView = UIView(frame: CGRect(x: frame.width - padding, y: 0, width: padding, height: frame.height))
        leftView = leftPaddingView
        leftViewMode = .always
        rightView = rightPaddingView
        rightViewMode = .always
    }
}
