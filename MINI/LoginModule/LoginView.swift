//
//  LoginView.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    private let helloLabel = UILabel(text: "Hello, Yanis!", font: .boldSystemFont(ofSize: 30), color: .black)
    private let nameField = UITextField()
    private let passField = UITextField()
    private let loginButt = UIButton(label: "Login", color: .systemCyan, height: 50, width: 100)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoginView {
    func initialize() {
        createHelloLabel()
        createNameField()
        createPassField()
        createLoginButton()
    }
    func createHelloLabel() {
        addSubview(helloLabel)
        helloLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(20)
        }
    }
    func createNameField() {
        addSubview(nameField)
        nameField.backgroundColor = .red
        nameField.snp.makeConstraints { make in
            make.top.equalTo(helloLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    func createPassField() {
        addSubview(passField)
        passField.backgroundColor = .green
        passField.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    func createLoginButton() {
        addSubview(loginButt)
        loginButt.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
        loginButt.addPulseAnimation()
    }
}
