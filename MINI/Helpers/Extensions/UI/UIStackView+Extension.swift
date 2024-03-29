//
//  UIStackView+Extension.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit

extension UIStackView {
    convenience init(
        _ arrangedSubviews: [UIView],
        _ axis: NSLayoutConstraint.Axis = .horizontal,
        spacing: CGFloat = 0
    ) {
        self.init(frame: .zero)
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
    }
    
    func setCustomAppearance(
        _ axis: NSLayoutConstraint.Axis = .vertical,
        spacing: CGFloat = 10,
        distribution: UIStackView.Distribution = .fillEqually
    ) {
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
    }
}
