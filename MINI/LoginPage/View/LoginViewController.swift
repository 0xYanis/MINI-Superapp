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
    }
    
    lazy private var animationView = AnimationView()
    lazy private var loginView = LoginView()
}

private extension LoginViewController {
    func initialize() {
        view.backgroundColor = .white
        view.insertSubview(animationView, at: 0)
        view.insertSubview(loginView, at: 1)
        setViewsСonstraints()
        setViewsRadius()
        setViewsShadow()
    }
    
    func setViewsСonstraints() {
        let height = view.frame.width
        animationView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().inset(height / 1.6)
        }
        loginView.snp.makeConstraints { make in
            make.top.equalTo(animationView.snp.bottom).inset(80)
            make.height.equalToSuperview().inset(height / 1.7)
            make.left.right.equalToSuperview().inset(45)
        }
    }
    
    func setViewsRadius() {
        animationView.layer.cornerRadius = 30
        animationView.layer.masksToBounds = true
        loginView.layer.cornerRadius = 30
    }
    
    func setViewsShadow() {
        loginView.layer.shadowColor = UIColor.black.cgColor
        loginView.layer.shadowOpacity = 0.3
        loginView.layer.shadowOffset = CGSize(width: 0, height: 0)
        loginView.layer.shadowRadius = 10
    }
}
