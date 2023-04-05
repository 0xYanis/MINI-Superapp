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
    private let accountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Already have been account?", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 12)
        return button
    }()
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Let's go!", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemCyan
        return button
    }()
    
    private let loginField = LoginField()
    private let passwordField = PasswordField()
    private let secondPasswordField = PasswordField()
}

private extension LoginView {
    func initialize() {
        backgroundColor = .white
        addSubview(loginLabel)
        addSubview(loginField)
        addSubview(passwordLabel)
        addSubview(passwordField)
        addSubview(secondPasswordField)
        addSubview(accountButton)
        addSubview(loginButton)
        setViewsСonstraints()
    }
    func setViewsСonstraints() {
        loginLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(20)
        }
        loginField.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(loginField.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(20)
        }
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        secondPasswordField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        accountButton.snp.makeConstraints { make in
            make.top.equalTo(secondPasswordField.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(accountButton.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.bottom.equalToSuperview().inset(30)
        }
    }
}
