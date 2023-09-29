//
//  OnboardingView.swift
//  MINI
//
//  Created by Yan Rybkin on 08.09.2023.
//

import UIKit
import Lottie

final class OnboardingView: UIViewController {
    
    private let entity: OnboardingEntity
    
    private var animationView: LottieAnimationView?
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    
    init(entity: OnboardingEntity) {
        self.entity = entity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-80)
            make.height.equalToSuperview().multipliedBy(0.52)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationView?.play()
    }
    
    private func initialize() {
        configureAnimation()
        createStackView()
        configureTitle()
        configureMessage()
    }
    
    private func configureAnimation() {
        animationView = .init(name: entity.animation)
        animationView?.contentMode = .scaleAspectFit
        animationView?.animationSpeed = 0.7
        animationView?.loopMode = .loop
    }
    
    private func createStackView() {
        guard let animationView else { return }
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(animationView)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(messageLabel)
        
        stackView.spacing = 40
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
    }
    
    private func configureTitle() {
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.text = entity.title
    }
    
    private func configureMessage() {
        messageLabel.font = .systemFont(ofSize: 16)
        messageLabel.textColor = .gray
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.text = entity.message
    }
    
    deinit {
        animationView?.stop()
        animationView = nil
    }
    
}
