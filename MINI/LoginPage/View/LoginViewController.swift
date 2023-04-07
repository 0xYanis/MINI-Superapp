//
//  LoginViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 05.04.2023.
//

import UIKit
import SnapKit

protocol LoginViewControllerProtocol: AnyObject {
    func isNotSecureField(secure: Bool)
    func resizeLoginView()
}

class LoginViewController: UIViewController {
    
    var presenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    lazy private var animationView = AnimationView()
    lazy private var loginView = LoginView()
}

extension LoginViewController: LoginViewControllerProtocol {
    func isNotSecureField(secure: Bool) {
        loginView.passwordField.isSecureTextEntry = secure
        loginView.secondPasswordField.isSecureTextEntry = secure
    }
    
    func resizeLoginView() {
        shrinkLoginView()
    }
}

extension LoginViewController {
    @objc func lockAction() {
        loginView.lockButton.addPulseAnimation()
        presenter?.didTapLock()
    }
    @objc func accountAction() {
        loginView.accountButton.addPulseAnimation()
        presenter?.didTapAccount()
    }
    @objc func loginAction() {
        loginView.loginButton.addPulseAnimation()
        presenter?.didTapLogin()
    }
}

private extension LoginViewController {
    func initialize() {
        view.backgroundColor = .white
        view.insertSubview(animationView, at: 0)
        view.insertSubview(loginView, at: 1)
        setButtonTargets()
        setViewsСonstraints()
        setViewsRadius()
        setViewsShadow()
    }
    
    func setButtonTargets() {
        loginView.lockButton.addTarget(
            self, action: #selector(lockAction), for: .touchUpInside
        )
        loginView.accountButton.addTarget(
            self, action: #selector(accountAction), for: .touchUpInside
        )
        loginView.loginButton.addTarget(
            self, action: #selector(loginAction), for: .touchUpInside
        )
    }
    
    func setViewsСonstraints() {
        let height = view.frame.width
        setAnimationView(height: height)
        setLoginView(height: height)
    }
    
    func setAnimationView(height: CGFloat) {
        animationView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().inset(height / 1.6)
        }
    }
    
    func setLoginView(height: CGFloat) {
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
    
    func shrinkLoginView() {
        UIView.animate(withDuration: 0.3) {
            self.loginView.snp.updateConstraints { make in
                make.height.equalToSuperview().inset(self.loginView.frame.height / 1.7 - 50)
            }
            self.view.layoutIfNeeded()
        }
    }
}
