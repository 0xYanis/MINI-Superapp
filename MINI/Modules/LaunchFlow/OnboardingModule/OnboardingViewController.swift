//
//  OnboardingViewController.swift
//  MINI
//
//  Created by Yanis on 05.12.2023.
//

import UIKit
import Lottie
import SnapKit
import SPPageController

protocol OnboardingViewProtocol: AnyObject {
    func setData(entities: [OnboardingEntity])
}

final class OnboardingViewController: UIViewController {
    
    var presenter: OnboardingPresenterProtocol?
    
    private var controllers = [OnBoardingController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPageController()
    }
    
}

// MARK: - OnboardingViewProtocol

extension OnboardingViewController: OnboardingViewProtocol {
    
    func setData(entities: [OnboardingEntity]) {
        controllers = entities.map { entity in
            return OnBoardingController(entity)
        }
        controllers.last?.isLastPage = true
    }
    
}

// MARK: - Private methods & computed properties

private extension OnboardingViewController {
    
    func setPageController() {
        view.backgroundColor = .secondarySystemBackground
        let pageController = SPPageController(
            childControllers: controllers,
            navigationOrientation: .horizontal,
            system: .page
        )
        pageController.modalPresentationStyle = .fullScreen
        pageController.modalTransitionStyle = .coverVertical
        present(pageController, animated: true)
    }
    
}

fileprivate final class OnBoardingController: UIViewController {
    
    var isLastPage: Bool = false
    
    private var animationView: LottieAnimationView?
    private var titleLabel     = UILabel()
    private var messageLabel   = UILabel()
    private var continueButton = UIButton()
    
    init(_ entity: OnboardingEntity) {
        titleLabel.text = entity.title
        messageLabel.text = entity.message
        animationView = LottieAnimationView(name: "order")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isLastPage { showButton() }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isLastPage { hideButton() }
    }
    
    private func setupUI() {
        configureUI()
        guard let animationView else { return }
        view.addSubview(animationView)
        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        view.addSubview(continueButton)
        
        animationView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(60)
            $0.centerX.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
        
        continueButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        
        continueButton.roundCorners(radius: 12)
    }
    
    private func configureUI() {
        guard let animationView else { return }
        animationView.play()
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFill
        
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        messageLabel.font = .systemFont(ofSize: 16)
        messageLabel.numberOfLines = 3
        messageLabel.textAlignment = .center
        messageLabel.textColor = .secondaryLabel
        
        continueButton.setTitle("Продолжить!", for: .normal)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = .systemOrange
        continueButton.addPulseAnimation()
        continueButton.isHidden = true
    }
    
    private func showButton() {
        continueButton.isHidden = false
    }
    
    private func hideButton() {
        continueButton.isHidden = true
    }
    
}
