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
    
}

private extension AnimationView {
    func initalize() {
        backgroundColor = .systemCyan
        animationView.contentMode = .scaleAspectFit
        addSubview(animationView)
        animationView.snp.makeConstraints({ make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        })
        animationView.loopMode = .autoReverse
        animationView.play()
    }
}
