//
//  AppCoordinator.swift
//  MINI
//
//  Created by Yan Rybkin on 20.09.2023.
//

import UIKit

// MARK: - Coordinator interface

protocol ICoordinator: AnyObject {
    var rootController: UIViewController? { get set }
    func start()
}

final class AppCoordinator: ICoordinator {
    
    var rootController: UIViewController?
    private var authManager: FBAuthProtocol?
    
    public func start() {
        self.rootController = makeRootController()
    }
    
}

// MARK: - Private constants, methods & computed properties

private extension AppCoordinator {
    
    enum Consts: String {
        case seenOnboarding
    }
    
    enum StartState {
        case onBoarding
        case login
        case main
    }
    
    func makeRootController() -> UIViewController {
        switch currentState {
        case .onBoarding : return OnboardingBuilder.build()
        case .login      : return withNav(LoginBuilder.build())
        case .main       : return BaseTabBarController()
        }
    }
    
    var currentState: StartState {
        if isSeenOnboarding {
            return isLogin ? .main : .login
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
    
    private func withNav(_ viewController: UIViewController) -> UIViewController {
        UINavigationController(rootViewController: viewController)
    }
    
}

final class OnBoardingCoordinator {
    
    weak var parentCoordinator: AppCoordinator?
    
    lazy private var view: UIViewController = {
        OnboardingBuilder.build()
    }()
    
    func startFlow() {
        
    }
    
    func stopFlow() {
        parentCoordinator?.start()
    }
    
}

final class LoginCoordinator {
    
}

final class TabBarCoordinator {
    
}
