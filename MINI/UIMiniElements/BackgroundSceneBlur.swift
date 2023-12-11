//
//  BackgroundSceneBlur.swift
//  MINI
//
//  Created by Yanis on 11.12.2023.
//

import UIKit

final class BackgroundSceneBlur {
    
    static let shared = BackgroundSceneBlur()
    private init() {}
    
    func showBlur(on scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.alpha = 0.0
        blurView.frame = windowScene.coordinateSpace.bounds
        windowScene.keyWindow?.rootViewController?.view.addSubview(blurView)
        
        UIView.animate(withDuration: 0.3) {
            blurView.alpha = 1.0
        }
    }
    
    func removeBlur(from scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
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
