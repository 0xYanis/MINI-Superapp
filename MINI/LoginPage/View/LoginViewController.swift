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
        view.addSubview(animationView)
        view.addSubview(loginView)
        setViewСonstraints()
    }
    func setViewСonstraints() {
        animationView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        loginView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
