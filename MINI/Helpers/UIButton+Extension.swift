//
//  Extensions.swift
//  MINI
//
//  Created by Yan Rybkin on 06.04.2023.
//

import UIKit
import SnapKit

extension UIButton {
    convenience init(label: String, color: UIColor, cornerRadius: CGFloat = 15) {
        self.init(frame: .zero)
        self.setTitle(label, for: .normal)
        self.backgroundColor = color
        self.tintColor = .white
        self.layer.cornerRadius = cornerRadius
    }
    convenience init(systemImage: String, color: UIColor, size: CGFloat) {
        self.init(frame: .zero)
        let image = UIImage(systemName: systemImage)
        self.setImage(image, for: .normal)
        self.tintColor = color
        let scale = size / (image?.size.width ?? 1)
        self.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    func addPulseAnimation() {
        addTarget(self, action: #selector(pulseButton), for: .touchUpInside)
    }
    
    @objc private func pulseButton() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.13
        pulse.fromValue = 0.83
        pulse.toValue = 1.0
        pulse.initialVelocity = 2.0
        layer.add(pulse, forKey: "pulse")
    }
}
