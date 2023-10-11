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
    
    private var animationView: LottieAnimationView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        animationView?.play()
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
        animationView?.stop()
        animationView = nil
    }
    
}

private extension LoginAnimationView {
    func initialize() {
        configureAnimation()
        createAnimationConstraints()
    }
    
    func configureAnimation() {
        animationView = .init(name: "rocket")
        animationView?.frame = bounds
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 0.7
    }
    
    func createAnimationConstraints() {
        guard let animationView else { return }
        addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
    }
    
}
