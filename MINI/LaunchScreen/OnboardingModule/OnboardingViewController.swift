//
//  OnboardingViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 07.09.2023.
//

import UIKit
import SnapKit

// MARK: - OnboardingViewProtocol

protocol OnboardingViewProtocol: AnyObject {
    
}

final class OnboardingViewController: UIPageViewController, OnboardingViewProtocol {
    
    public var presenter: OnboardingPresenterProtocol?
    
    // MARK: - Private properties
    
    private var pages: [UIViewController] = []
    private var initialPage: Int = 0
    
    private let skipButton     = UIButton()
    private let nextButton     = UIButton()
    private let pageControl    = UIPageControl()
    private let continueButton = UIButton()
    
    // MARK: - Lifecycle
    
    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey : Any]? = nil
    ) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureConstraints()
    }
    
}

// MARK: - Private properties

private extension OnboardingViewController {
    
    func initialize() {
        view.backgroundColor = .back2MINI
        dataSource = self
        delegate = self
        addDataSource()
        configurePageControl()
        configureSkipButton()
        configureNextButton()
        configureContinueButton()
    }
    
    func addDataSource() {
        guard let entities = presenter?.content else { return }
        let firstPage  = OnboardingView(entity: entities[0])
        let secondPage = OnboardingView(entity: entities[1])
        let thirdPage  = OnboardingView(entity: entities[2])
        
        pages.append(firstPage)
        pages.append(secondPage)
        pages.append(thirdPage)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
    }
    
    func configurePageControl() {
        pageControl.addTarget(self, action: #selector(pageControlAction), for: .valueChanged)
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        view.addSubview(pageControl)
    }
    
    func configureSkipButton() {
        skipButton.setTitleColor(.systemOrange, for: .normal)
        skipButton.setTitle("Пропуск", for: .normal)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .primaryActionTriggered)
        view.addSubview(skipButton)
    }
    
    func configureNextButton() {
        nextButton.setTitleColor(.systemOrange, for: .normal)
        nextButton.setTitle("Дальше", for: .normal)
        nextButton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
        view.addSubview(nextButton)
    }
    
    func configureContinueButton() {
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.setTitle("Понятно", for: .normal)
        continueButton.backgroundColor = .systemOrange
        continueButton.roundCorners(radius: 12)
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        view.addSubview(continueButton)
    }
    
    func configureConstraints() {
        skipButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(40)
        }
        
        nextButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(40)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.bottom.equalToSuperview().inset(60)
        }
        
        continueButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
            make.width.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(-90)
        }
    }
    
}

// MARK: - Action methods

private extension OnboardingViewController {
    
    @objc
    func continueTapped(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            self?.presenter?.readyToContinue()
        }
    }
    
    @objc
    func pageControlAction(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true)
        animateControlsIfNeeded()
    }
    
    @objc
    func skipTapped(_ sender: UIButton) {
        let lastPageIndex = pages.count - 1
        pageControl.currentPage = lastPageIndex
        goToSpecificPage(index: lastPageIndex, ofViewControllers: pages)
        animateControlsIfNeeded()
    }
    
    @objc
    func nextTapped(_ sender: UIButton) {
        pageControl.currentPage += 1
        goToNextPage()
        animateControlsIfNeeded()
    }
    
}

// MARK: - UIPageViewControllerDataSource

extension OnboardingViewController: UIPageViewControllerDataSource {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard
            let currentIndex = pages.firstIndex(of: viewController)
        else { return nil }
        
        return currentIndex == 0 ? pages.last : pages[currentIndex - 1]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard
            let currentIndex = pages.firstIndex(of: viewController)
        else { return nil }
        
        return currentIndex < pages.count - 1 ? pages[currentIndex + 1] : pages.first
    }
    
}

// MARK: - UIPageViewControllerDelegate

extension OnboardingViewController: UIPageViewControllerDelegate {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard
            let viewControllers = pageViewController.viewControllers,
            let currentIndex = pages.firstIndex(of: viewControllers[0])
        else { return }
        
        pageControl.currentPage = currentIndex
        animateControlsIfNeeded()
    }
    
    private func animateControlsIfNeeded() {
        let lastPage = pageControl.currentPage == pages.count - 1
        lastPage == true ? hideControls() : showControls()
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.2, delay: 0, options: [.curveEaseOut]
        ) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideControls() {
        UIView.animate(withDuration: 0.3, delay: 0) { [weak self] in
            self?.removeConstraints()
        }
    }
    
    private func showControls() {
        UIView.animate(withDuration: 0.3, delay: 0) { [weak self] in
            self?.configureConstraints()
        }
    }
    
    private func removeConstraints() {
        skipButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(-90)
        }
        
        nextButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(-90)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.bottom.equalToSuperview().inset(-90)
        }
        
        continueButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
            make.width.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(60)
        }
    }
    
}
