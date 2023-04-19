//
//  UIView+Extension.swift
//  MINI
//
//  Created by Yan Rybkin on 15.04.2023.
//

import UIKit

extension UIView {
    func radiusAndShadow(radius: Double, color: UIColor = .black, opacity: Float = 0.2, shadowSize: CGFloat = 15) {
        roundCorners(radius: radius)
        shadow(color: color, opacity: opacity, radius: shadowSize)
    }
    func shadow(color: UIColor, opacity: Float, radius: CGFloat) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.masksToBounds = false
    }
    func roundCorners(radius: Double) {
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
    }
    func roundBottomCorners(radius: CGFloat) {
        let cornerRadius: CGFloat = radius
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}
