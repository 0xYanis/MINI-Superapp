//
//  OnboardingViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 07.09.2023.
//

import UIKit

// MARK: - OnboardingViewProtocol

protocol OnboardingViewProtocol: AnyObject {
    
}

final class OnboardingViewController: UIPageViewController, OnboardingViewProtocol {
    
    public var presenter: OnboardingPresenterProtocol?
    
    // MARK: - Private properties
    
    private var pages: [UIViewController] = []
    private var initialPage: Int = 0
    
    private let skipButton  = UIButton()
    private let nextButton  = UIButton()
    private let pageControl = UIPageControl()
    
    // MARK: - Private animation properties
    
    private var pageControlBottom: NSLayoutConstraint?
    private var skipButtonTop: NSLayoutConstraint?
    private var nextButtonTop: NSLayoutConstraint?
    
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
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        view.addSubview(pageControl)
    }
    
    func configureSkipButton() {
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.setTitleColor(.systemBlue, for: .normal)
        skipButton.setTitle("Пропуск", for: .normal)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .primaryActionTriggered)
        view.addSubview(skipButton)
    }
    
    func configureNextButton() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitleColor(.systemBlue, for: .normal)
        nextButton.setTitle("Дальше", for: .normal)
        nextButton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
        view.addSubview(nextButton)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skipButton.leadingAnchor.constraint(
                equalToSystemSpacingAfter: view.leadingAnchor,
                multiplier: 2),
            view.trailingAnchor.constraint(
                equalToSystemSpacingAfter: nextButton.trailingAnchor,
                multiplier: 2),
        ])
        // animations
        skipButtonTop = skipButton.topAnchor.constraint(
            equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor,
            multiplier: 2)
        nextButtonTop = nextButton.topAnchor.constraint(
            equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor,
            multiplier: 2)
        pageControlBottom = view.bottomAnchor.constraint(
            equalToSystemSpacingBelow: pageControl.bottomAnchor,
            multiplier: 2)
        
        skipButtonTop?.isActive     = true
        nextButtonTop?.isActive     = true
        pageControlBottom?.isActive = true
    }
    
}

// MARK: - Action methods

private extension OnboardingViewController {
    
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
        pageControlBottom?.constant = -100
        skipButtonTop?.constant = -100
        nextButtonTop?.constant = -100
    }
    
    private func showControls() {
        pageControlBottom?.constant = 30
        skipButtonTop?.constant = 16
        nextButtonTop?.constant = 16
    }
    
}
