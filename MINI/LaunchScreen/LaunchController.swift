//
//  LaunchController.swift
//  MINI
//
//  Created by Yan Rybkin on 13.06.2023.
//

import UIKit
import SnapKit

final class LaunchController: UIViewController {
    
    private lazy var emojiLabel = UILabel()
    private lazy var imageView  = UIImageView()
    
    private let emojis : [String]  = ["🏦", "🛩", "🛒", "🚀"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        startAnimations()
    }
}

private extension LaunchController {
    func initialize() {
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "gradientbackground")
        view.insertSubview(imageView, at: 0)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(additionalSafeAreaInsets.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(additionalSafeAreaInsets.bottom)
        }
        
        emojiLabel.text = "🏦"
        emojiLabel.font = .systemFont(ofSize: 100)
        view.insertSubview(emojiLabel, at: 1)
        emojiLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func startAnimations() {
        var currentIndex: Int = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [self] timer in
            guard currentIndex < emojis.count else {
                transitionToMainView()
                timer.invalidate()
                return
            }
            
            emojiLabel.text = emojis[currentIndex]
            currentIndex += 1
            
            UIView.animate(withDuration: 0.25, animations: {
                self.emojiLabel.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            }) { _ in
                UIView.animate(withDuration: 0.25) {
                    self.emojiLabel.transform = CGAffineTransform.identity
                }
            }
        }
    }
    
    func transitionToMainView() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let delegate = windowScene.delegate as? SceneDelegate {
            let window = UIWindow(windowScene: windowScene)
            let mainView = AuthenticationManager.auth(to: window)
            
            window.rootViewController = mainView
            window.overrideUserInterfaceStyle = .dark
            window.backgroundColor = UIColor(named: "backColor")
            window.tintColor = .systemOrange
            delegate.window = window
            window.makeKeyAndVisible()
        }
    }
}
