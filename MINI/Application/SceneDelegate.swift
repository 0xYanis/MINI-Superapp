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
    
    func sceneWillResignActive(_ scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.alpha = 0.0
        blurView.frame = windowScene.coordinateSpace.bounds
        windowScene.keyWindow?.rootViewController?.view.addSubview(blurView)
        
        UIView.animate(withDuration: 0.3) {
            blurView.alpha = 1.0
        }
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene else { return }
        windowScene.keyWindow?.rootViewController?.view.subviews.forEach { view in
            if view is UIVisualEffectView {
                UIView.animate(withDuration: 0.1) {
                    view.alpha = 0.0
                } completion: { _ in
                    view.removeFromSuperview()
                }
            }
        }
    }
    
}

