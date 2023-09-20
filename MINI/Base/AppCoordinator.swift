//
//  AppCoordinator.swift
//  MINI
//
//  Created by Yan Rybkin on 20.09.2023.
//

import UIKit

// MARK: - Coordinator interface

protocol ICoordinator: AnyObject {
    var window: UIWindow? { get set }
    func start()
}

// MARK: - Delegate

protocol AppCoordinatorDelegate: AnyObject {
    func canLaunch()
}

final class AppCoordinator: ICoordinator {
    
    // MARK: - Public properties
    
    public var window: UIWindow?
    
    // MARK: - Private properties
    private var launchController: LaunchController?
    private var authManager: FBAuthProtocol = FBAuthManager()
    private var islogin: Bool = false
    
    init() { checkLogin() }
    
    // MARK: - Public methods
    
    public func start() {
        launchController = LaunchController()
        guard let launch = launchController else { return }
        setRoot(launch)
        launch.completion = { [weak self] in
            guard let self = self else { fatalError() }
            self.islogin ? self.showMain() : self.showLogin(from: launch)
        }
    }
    
    // MARK: - Private methods
    
    private func showMain() {
        launchController?.completion = nil
        launchController = nil
        let baseTabbar = BaseTabBarController()
        setRoot(baseTabbar)
    }
    
    private func showLogin(from launch: UIViewController = UIViewController()) {
        let seenOnboarding = UserDefaults.standard.bool(forKey: "seenOnboarding")
        if seenOnboarding {
            let login = LoginBuilder.build()
            let navController = UINavigationController(rootViewController: login)
            setRoot(navController)
        } else {
            let controller = OnboardingBuilder.build(with: self)
            controller.modalPresentationStyle = .fullScreen
            launch.present(controller, animated: true)
        }
    }
    
    private func setRoot(_ viewController: UIViewController) {
        window?.backgroundColor = .backMINI
        window?.tintColor = .tintMINI
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    private func checkLogin() {
        if let _ = authManager.currentUser {
            islogin = true
        }
    }
    
}

// MARK: - AppCoordinatorDelegate

extension AppCoordinator: AppCoordinatorDelegate {
    
    func canLaunch() {
        showLogin()
    }
    
}

