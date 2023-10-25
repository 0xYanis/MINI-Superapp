//
//  AppCoordinator.swift
//  MINI
//
//  Created by Yan Rybkin on 20.09.2023.
//

import UIKit

// MARK: - Coordinator interface

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navController: UINavigationController { get set }
    func start()
}

final class MainCoordinator: Coordinator {
    
    public var childCoordinators = [Coordinator]()
    public var navController: UINavigationController
    
    private var authManager: FBAuthProtocol?
    private var launchController: LaunchController?
    
    private var didLaunch: Bool = false {
        didSet {
            startFlow()
            launchController?.completion = nil
            launchController = nil
        }
    }
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    public func start() {
        self.launchController = LaunchController()
        guard let lauch = launchController else { fatalError() }
        
        self.navController.pushViewController(lauch, animated: false)
        launchController?.completion = { [weak self] in
            self?.didLaunch = true
        }
    }
    
    public func childDidFinish(_ child: Coordinator?) {
        childCoordinators.removeAll { $0 === child }
        startFlow()
    }
    
    private func startFlow() {
        print(currentState)
        switch currentState {
        case .onBoarding: startOnboarding()
        case .login     : startLogin()
        case .tabBar    : startTabBar()
        }
    }
    
    private func startOnboarding() {
        let coordinator = OnBoardingCoordinator(navController: navController)
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    private func startLogin() {
        let coordinator = LoginCoordinator(navController: navController)
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    private func startTabBar() {
        let coordinator = TabBarCoordinator(navController: navController)
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
}

// MARK: - Private constants, methods & computed properties

private extension MainCoordinator {
    
    enum Consts: String {
        case seenOnboarding
    }
    
    enum AppState {
        case onBoarding
        case login
        case tabBar
    }
    
    var currentState: AppState {
        if isSeenOnboarding {
            return isLogin ? .tabBar : .login
        } else {
            return .onBoarding
        }
    }
    
    var isSeenOnboarding: Bool {
        let ud = UserDefaults.standard
        return ud.bool(forKey: Consts.seenOnboarding.rawValue)
    }
    
    var isLogin: Bool {
        defer { authManager = nil }
        self.authManager = FBAuthManager()
        return authManager?.currentUser != nil
    }
    
}

final class OnBoardingCoordinator: Coordinator {
    
    weak public var parentCoordinator: MainCoordinator?
    public var childCoordinators: [Coordinator] = []
    public var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func start() {
        let onBoarding = OnboardingBuilder.build(coordinator: self)
        onBoarding.modalPresentationStyle = .fullScreen
        onBoarding.modalTransitionStyle = .coverVertical
        navController.present(onBoarding, animated: true)
    }
    
    func finish() {
        navController.dismiss(animated: false)
        parentCoordinator?.childDidFinish(self)
    }
    
}

final class LoginCoordinator: Coordinator {
    
    weak public var parentCoordinator: MainCoordinator?
    public var childCoordinators: [Coordinator] = []
    public var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    public func start() {
        let login = LoginBuilder.build(coordinator: self)
        login.navigationItem.hidesBackButton = true
        navController.pushViewController(login, animated: false)
    }
    
    public func finish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    public func goToRegistrate() {
        let register = RegisterBuilder.build(coordinator: self)
        navController.pushViewController(register, animated: true)
    }
    
}

final class TabBarCoordinator: Coordinator {
    
    weak public var parentCoordinator: MainCoordinator?
    public var childCoordinators: [Coordinator] = []
    public var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    public func start() {
        // TODO: [Костыль] Навбар имеет Таббар, который внутри имеет навбары
        let tabBar = BaseTabBarController()
        tabBar.coordinator = self
        navController.setViewControllers([tabBar], animated: false)
        navController.isNavigationBarHidden = true
    }
    
    func finish() {
        navController.popViewController(animated: false)
        parentCoordinator?.childDidFinish(self)
    }
    
}
