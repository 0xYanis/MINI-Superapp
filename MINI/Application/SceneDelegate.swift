//
//  SceneDelegate.swift
//  MINI
//
//  Created by Yan Rybkin on 03.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private var coordinator: MainCoordinator?
    private var lauchController: LaunchController?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let navController = UINavigationController()
        coordinator = MainCoordinator(navController: navController)
        coordinator?.start()
        
        window.rootViewController = navController
        window.backgroundColor = .backMINI
        window.tintColor = .tintMINI
        window.makeKeyAndVisible()
    }
    
}

