//
//  LoginAnimationView.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit
import SnapKit
import Lottie

class LoginAnimationView: UIView {
    
    let animationView = LottieAnimationView(name: "hello")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundBottomCorners(radius: 60)
    }
    
    deinit {
        animationView.stop()
    }
}

private extension LoginAnimationView {
    func initialize() {
        configureAnimation()
        createAnimationConstraints()
        animationView.play()
    }
    func configureAnimation() {
        animationView.frame = bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
    }
    func createAnimationConstraints() {
        addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
