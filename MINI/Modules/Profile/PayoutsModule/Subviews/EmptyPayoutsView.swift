//
//  EmptyPayoutsView.swift
//  MINI
//
//  Created by Yan Rybkin on 18.08.2023.
//

import UIKit
import Lottie

final class EmptyPayoutsView: UIView {
    
    private lazy var stackView        = UIStackView()
    private lazy var messageLabel     = UILabel()
    private lazy var descriptionLabel = UILabel()
    private var animationView: LottieAnimationView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        animationView?.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(message: String,_ description: String) {
        self.messageLabel.text = message
        self.descriptionLabel.text = description
    }
    
    deinit {
        animationView?.stop()
        animationView = nil
    }
    
    override func safeAreaInsetsDidChange() {
        stackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }
    
}

private extension EmptyPayoutsView {
    
    func initialize() {
        configureLottie()
        createStackView()
        configureMessage()
        configureDescription()
    }
    
    func configureLottie() {
        animationView = .init(name: "empty")
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 0.7
    }
    
    func createStackView() {
        guard let animationView else { return }
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(animationView)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        stackView.axis = .vertical
        stackView.distribution = .fill
    }
    
    func configureMessage() {
        messageLabel.font = .boldSystemFont(ofSize: 30)
        messageLabel.textAlignment = .center
    }
    
    func configureDescription() {
        descriptionLabel.font = .boldSystemFont(ofSize: 17)
        descriptionLabel.textAlignment = .center
    }
    
}
