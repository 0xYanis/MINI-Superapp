//
//  UIImageView+Extension.swift
//  MINI
//
//  Created by Yan Rybkin on 19.04.2023.
//

import UIKit

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}
