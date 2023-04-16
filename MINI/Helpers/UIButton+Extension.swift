//
//  Extensions.swift
//  MINI
//
//  Created by Yan Rybkin on 06.04.2023.
//

import UIKit
import SnapKit

extension UIButton {
    convenience init(color: UIColor, cornerRadius: CGFloat, height: CGFloat, width: CGFloat) {
        self.init(frame: .zero)
        self.backgroundColor = color
        self.tintColor = .white
        self.layer.cornerRadius = cornerRadius
        self.snp.makeConstraints { make in
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
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
