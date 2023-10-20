//
//  SceneDelegate.swift
//  MINI
//
//  Created by Yan Rybkin on 03.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private var coordinator: ICoordinator?
    private var lauchController: LaunchController?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        self.coordinator = AppCoordinator()
        
        lauchController = LaunchController()
        
        window.rootViewController = lauchController
        window.makeKeyAndVisible()
        
        lauchController?.completion = { [weak self] in
            self?.coordinator?.start()
            self?.window?.rootViewController = self?.coordinator?.rootController
            self?.lauchController = nil
        }
    }
    
}

