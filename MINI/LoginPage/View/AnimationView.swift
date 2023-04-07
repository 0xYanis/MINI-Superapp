//
//  AnimationView.swift
//  MINI
//
//  Created by Yan Rybkin on 05.04.2023.
//

import UIKit
import SnapKit
import Lottie

class AnimationView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initalize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let animationView = LottieAnimationView(name: "scan")
    
    func animationIsHidden(hide: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.animationView.alpha = hide ? 0 : 1
        }, completion: { finished in
            self.animationView.isHidden = hide
        })
    }
}

private extension AnimationView {
    func initalize() {
        backgroundColor = .systemCyan
        animationView.contentMode = .scaleAspectFit
        addSubview(animationView)
        animationView.snp.makeConstraints({ make in
            make.center.equalToSuperview()
            make.height.equalTo(220)
        })
        animationView.loopMode = .autoReverse
        animationView.play()
    }
}
