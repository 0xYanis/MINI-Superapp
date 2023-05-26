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
    convenience init(systemImage: String, color: UIColor, size: CGFloat = 0) {
        self.init(frame: .zero)
        let image = UIImage(systemName: systemImage)
        self.setImage(image, for: .normal)
        self.tintColor = color
        if size != 0 {
            let scale = size / (image?.size.width ?? 1)
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    func addPulseAnimation() {
        addTarget(self, action: #selector(buttonPressed(_:)), for: .touchDown)
        addTarget(self, action: #selector(buttonReleased(_:)), for: [.touchUpInside, .touchDragExit])
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }

    @objc private func buttonReleased(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform.identity
        }
    }

}
