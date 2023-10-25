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
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    public func start() {
        self.launchController = LaunchController()
        guard let lauch = launchController else { fatalError() }
        
        self.navController.pushViewController(lauch, animated: false)
        lauch.completion = { [weak self] in
            self?.nextCoordinator()
            self?.launchController = nil
        }
    }
    
    public func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
        
        nextCoordinator()
    }
    
    private func nextCoordinator() {
        switch currentState {
        case .onBoarding: configure(OnBoardingCoordinator(navController: navController))
        case .login     : configure(LoginCoordinator(navController: navController))
        case .tabBar    : configure(TabBarCoordinator(navController: navController))
        }
    }
    
    private func configure(_ child: Coordinator) {
        childCoordinators.append(child)
        child.start()
    }
    
    public func startOnboarding() {
        let child = OnBoardingCoordinator(navController: navController)
        childCoordinators.append(child)
        child.start()
    }
    
    public func startLogin() {
        let child = LoginCoordinator(navController: navController)
        childCoordinators.append(child)
        child.start()
    }
    
    public func startTabbar() {
        let child = TabBarCoordinator(navController: navController)
        childCoordinators.append(child)
        child.start()
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
        navController.pushViewController(login, animated: true)
    }
    
    public func finish() {
        navController.popViewController(animated: false)
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
        let tabBar = BaseTabBarController()
        tabBar.coordinator = self
        tabBar.modalPresentationStyle = .fullScreen
        navController.present(tabBar, animated: false)
    }
    
    func finish() {
        navController.dismiss(animated: true)
        parentCoordinator?.childDidFinish(self)
    }
    
}
