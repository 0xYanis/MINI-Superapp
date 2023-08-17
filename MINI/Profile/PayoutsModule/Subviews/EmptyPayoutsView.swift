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
    private lazy var lottieView       = LottieAnimationView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(message: String,_ description: String) {
        self.messageLabel.text = message
        self.descriptionLabel.text = description
    }
    
}

private extension EmptyPayoutsView {
    
    func initialize() {
        createStackView()
        configureMessage()
        configureDescription()
        configureLottie()
    }
    
    func createStackView() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(lottieView)
        
        stackView.spacing = 30
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
    }
    
    func configureMessage() {
        messageLabel.font = .boldSystemFont(ofSize: 30)
        messageLabel.textAlignment = .center
    }
    
    func configureDescription() {
        descriptionLabel.font = .boldSystemFont(ofSize: 17)
        descriptionLabel.textAlignment = .center
    }
    
    func configureLottie() {
        lottieView.loopMode = .loop
        lottieView.play()
    }
    
}
