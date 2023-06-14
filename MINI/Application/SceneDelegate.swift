//
//  SceneDelegate.swift
//  MINI
//
//  Created by Yan Rybkin on 03.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = LaunchController()
        window.tintColor = .systemOrange
        window.backgroundColor = UIColor(named: "backColor")
        window.overrideUserInterfaceStyle = .dark 
        self.window = window
        UIApplication.shared.shortcutItems = DeepLinkManager.buildShortCuts()
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

