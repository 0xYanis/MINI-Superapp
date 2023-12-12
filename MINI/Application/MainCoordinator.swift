//
//  MainCoordinator.swift
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
    
    // MARK: - Public properties
    
    public var childCoordinators = [Coordinator]()
    public var navController: UINavigationController
    
    // MARK: - Private properties
    
    private var authManager: FBAuthProtocol?
    private var launchController: LaunchController?
    private var didLaunch: Bool = false {
        didSet {
            startFlow()
            launchController?.completion = nil
            launchController = nil
        }
    }
    
    // MARK: - Init
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    // MARK: - Public methods
    
    public func start() {
        self.launchController = LaunchController()
        guard let lauch = launchController else { fatalError() }
        
        self.navController.push(lauch)
        launchController?.completion = { [weak self] in
            self?.didLaunch = true
        }
    }
    
    public func childDidFinish(_ child: Coordinator?) {
        childCoordinators.removeAll { $0 === child }
        startFlow()
    }
    
    // MARK: - Private methods
    
    private func startFlow() {
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
        let coordinator = AuthCoordinator(navController: navController)
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
