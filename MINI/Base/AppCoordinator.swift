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

final class AppCoordinator: ICoordinator {
    
    // MARK: - Public properties
    
    public var window: UIWindow?
    
    // MARK: - Private properties
    private var authManager: FBAuthProtocol = FBAuthManager()
    private var islogin: Bool = false
    
    init() { checkLogin() }
    
    // MARK: - Public methods
    
    public func start() {
        let launch = LaunchController()
        setRoot(launch)
        launch.completion = { [weak self] in
            guard let self = self else { fatalError() }
            self.islogin ? self.showMain() : self.showLogin(from: launch)
        }
    }
    
    // MARK: - Private methods
    
    private func showMain() {
        let baseTabbar = BaseTabBarController()
        setRoot(baseTabbar)
    }
    
    private func showLogin(from launch: UIViewController) {
        let seenOnboarding = UserDefaults.standard.bool(forKey: "seenOnboarding")
        if seenOnboarding {
            let controller = LoginBuilder.build()
            let navController  = UINavigationController(rootViewController: controller)
            setRoot(navController)
        } else {
            UserDefaults.standard.set(true, forKey: "seenOnboarding")
            let controller = OnboardingBuilder.build()
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
