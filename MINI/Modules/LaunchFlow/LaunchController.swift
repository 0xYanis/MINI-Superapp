//
//  LaunchController.swift
//  MINI
//
//  Created by Yan Rybkin on 13.06.2023.
//

import UIKit
import SnapKit

final class LaunchController: UIViewController {
    
    public var completion: (() -> Void)?
    
    private let emojis : [String]  = ["🏦", "🛩", "🛒", "🚀"]
    
    private lazy var emojiLabel = UILabel()
    private lazy var imageView  = UIImageView()
    
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
        emojiLabel.font = .systemFont(ofSize: 75)
        view.insertSubview(emojiLabel, at: 1)
        emojiLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func startAnimations() {
        UIView.animate(withDuration: 0.3, animations: {
            self.emojiLabel.transform = CGAffineTransform(scaleX: 1.33, y: 1.33)
        }) {_ in
            self.changeEmojisAndPulseAnimations()
        }
    }
    
    func changeEmojisAndPulseAnimations() {
        var currentIndex: Int = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [self] timer in
            guard currentIndex < emojis.count else {
                startTransition()
                timer.invalidate()
                return
            }
            
            UIView.animate(withDuration: 0.25, animations: {
                self.emojiLabel.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            }) { _ in
                UIView.animate(withDuration: 0.25) {
                    self.emojiLabel.transform = CGAffineTransform.identity
                    self.emojiLabel.text = self.emojis[currentIndex]
                    currentIndex += 1
                }
            }
        }
    }
    
    func startTransition() {
        completion?()
    }
    
}
