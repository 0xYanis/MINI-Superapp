//
//  LoginView.swift
//  MINI
//
//  Created by Yan Rybkin on 05.04.2023.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: LoginViewDelegate?
    let passwordField = PasswordField()
    let secondPasswordField = PasswordField()
    
    private let loginField = LoginField()
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "Login"
        return label
    }()
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "Password"
        return label
    }()
    
    let accountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Already have been account?", for: .normal)
        button.setTitleColor(.systemCyan, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        return button
    }()
    let lockButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "lock"), for: .normal)
        return button
    }()
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Let's go!", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemCyan
        return button
    }()
}

private extension LoginView {
    func initialize() {
        backgroundColor = .white
        addSubview(loginLabel)
        addSubview(loginField)
        addSubview(passwordLabel)
        addSubview(passwordField)
        passwordField.addSubview(lockButton)
        addSubview(secondPasswordField)
        addSubview(accountButton)
        addSubview(loginButton)
        setViewsСonstraints()
        lockButton.addTarget(
            self, action: #selector(lockAction), for: .touchUpInside
        )
        accountButton.addTarget(
            self, action: #selector(accountAction), for: .touchUpInside
        )
        loginButton.addTarget(
            self, action: #selector(loginAction), for: .touchUpInside
        )
    }
    
    @objc func lockAction() {
        delegate?.didTapLock()
    }
    
    @objc func accountAction() {
        delegate?.didTapAccount()
    }
    
    @objc func loginAction() {
        delegate?.didTapLogin()
    }
    
    func setViewsСonstraints() {
        setLoginLabel()
        setLoginField()
        setPasswordLabel()
        setPasswordField()
        setLockButton()
        setSecondPasswordField()
        setAccountButton()
        setLoginButton()
    }
    func setLoginLabel() {
        loginLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(20)
        }
    }
    func setLoginField() {
        loginField.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
    func setPasswordLabel() {
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(loginField.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(20)
        }
    }
    func setPasswordField() {
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
    func setLockButton() {
        lockButton.snp.makeConstraints { make in
            make.centerY.equalTo(passwordField.snp.centerY)
            make.right.equalTo(passwordField.snp.right).inset(10)
        }
    }
    func setSecondPasswordField() {
        secondPasswordField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
    func setAccountButton() {
        accountButton.snp.makeConstraints { make in
            make.top.equalTo(secondPasswordField.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
    }
    func setLoginButton() {
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(accountButton.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.bottom.equalToSuperview().inset(30)
        }
    }
}
