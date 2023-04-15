//
//  Extensions.swift
//  MINI
//
//  Created by Yan Rybkin on 06.04.2023.
//

import UIKit

extension UIButton {
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

extension UILabel {
    
}
