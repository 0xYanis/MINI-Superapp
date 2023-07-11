//
//  SceneDelegate.swift
//  MINI
//
//  Created by Yan Rybkin on 03.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = LaunchController()
        window.tintColor = .tintMINI
        window.backgroundColor = .backMINI
        self.window = window
        
        UIApplication.shared.shortcutItems = DeepLinkManager.buildShortCuts()
        window.makeKeyAndVisible()
    }
    
}

