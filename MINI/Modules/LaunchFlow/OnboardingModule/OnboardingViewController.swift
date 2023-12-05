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
    
    var currentIndex: Int = 0 {
        didSet {
            navigationItem.leftBarButtonItem?.isEnabled = currentIndex != (controllers.count - 1)
            navigationItem.rightBarButtonItem?.isEnabled = currentIndex != (controllers.count - 1)
        }
    }
    
    private var controllers = [OnBoardingController]()
    private var pageController: SPPageController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPageController()
        setNavbar()
    }
    
    func continueTapped() {
        presenter?.readyToContinue()
    }
    
}

// MARK: - OnboardingViewProtocol

extension OnboardingViewController: OnboardingViewProtocol {
    
    func setData(entities: [OnboardingEntity]) {
        controllers = entities.enumerated().map { index, entity in
            let controller = OnBoardingController(tag: index, entity)
            controller.parentController = self
            return controller
        }
        controllers.last?.isLastPage = true
    }
    
}

// MARK: - Private methods & computed properties

private extension OnboardingViewController {
    
    func setPageController() {
        view.backgroundColor = .clear
        pageController = SPPageController(
            childControllers: controllers,
            navigationOrientation: .horizontal,
            system: .page
        )
        guard let pageController else { return }
        addChild(pageController)
        view.addSubview(pageController.view)
        pageController.didMove(toParent: self)
    }
    
    func setNavbar() {
        navigationItem.leftBarButtonItem = skipButton
        navigationItem.rightBarButtonItem = nextButton
    }
    
    var skipButton: UIBarButtonItem {
        UIBarButtonItem(
            title: "Skip",
            style: .plain,
            target: self,
            action: #selector(skipAction))
    }
    
    @objc func skipAction() {
        pageController?.safeScrollTo(
            index: (controllers.count - 1),
            animated: true
        )
    }
    
    var nextButton: UIBarButtonItem {
        UIBarButtonItem(
            title: "Next",
            style: .plain,
            target: self,
            action: #selector(nextAction))
    }
    
    @objc func nextAction() {
        if currentIndex != (controllers.count - 1) {
            pageController?.safeScrollTo(
                index: currentIndex + 1,
                animated: true
            )
        }
    }
    
}

fileprivate final class OnBoardingController: UIViewController {
    
    weak var parentController: OnboardingViewController?
    var isLastPage: Bool = false
    
    private var tag: Int
    private var animationView: LottieAnimationView?
    private var titleLabel     = UILabel()
    private var messageLabel   = UILabel()
    private var continueButton = UIButton()
    
    init(tag: Int,_ entity: OnboardingEntity) {
        self.tag = tag
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
        parentController?.currentIndex = self.tag
        if isLastPage { showButton() }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isLastPage { hideButton() }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
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
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        continueButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.height.equalToSuperview().multipliedBy(0.05)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        continueButton.roundCorners(radius: 10)
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
        
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        continueButton.setTitle("Понятно!", for: .normal)
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
    
    @objc
    private func continueTapped() {
        parentController?.continueTapped()
    }
    
}
