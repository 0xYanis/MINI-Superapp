//
//  LoginViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 05.04.2023.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        
        print(view.frame.height)
    }
    
    lazy private var animationView = AnimationView()
    lazy private var loginView = LoginView()
}

private extension LoginViewController {
    func initialize() {
        view.backgroundColor = .white
        view.insertSubview(animationView, at: 0)
        view.insertSubview(loginView, at: 1)
        setViewsRadius()
        setViewsShadow()
        setViewsСonstraints()
    }
    func setViewsRadius() {
        animationView.layer.cornerRadius = 30
        animationView.layer.masksToBounds = true
        
        loginView.layer.cornerRadius = 30
        loginView.layer.masksToBounds = false
        loginView.clipsToBounds = false
    }
    func setViewsShadow() {
        loginView.layer.shadowColor = UIColor.black.cgColor
        loginView.layer.shadowOpacity = 0.3
        loginView.layer.shadowOffset = CGSize(width: 0, height: 0)
        loginView.layer.shadowRadius = 10
    }
    func setViewsСonstraints() {
        animationView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().inset(view.frame.width / 1.5)
        }
        loginView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(225)
            make.left.right.equalToSuperview().inset(45)
        }
    }
}
