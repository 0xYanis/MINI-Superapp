//
//  LoginView.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    private let helloLabel = UILabel(text: "Welcome!", font: .boldSystemFont(ofSize: 26), color: .systemOrange)
    let faceIDButton = UIButton(systemImage: "faceid", color: .systemOrange, size: 26)
    let nameField = UITextField()
    let passField = UITextField()
    let loginButt = UIButton(label: "Login!", color: .systemOrange)
    
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
        createFaceIDButton()
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
    func createFaceIDButton() {
        addSubview(faceIDButton)
        faceIDButton.addPulseAnimation()
        faceIDButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(20)
        }
    }
    func createNameField() {
        addSubview(nameField)
        nameField.keyboardType = .emailAddress
        nameField.setCustomAppearance(withBorderColor: .systemOrange, cornerRadius: 15, padding: 10)
        nameField.placeholder = "Введите Имя"
        nameField.snp.makeConstraints { make in
            make.top.equalTo(helloLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    func createPassField() {
        addSubview(passField)
        passField.isSecureTextEntry = true
        passField.setCustomAppearance(withBorderColor: .systemOrange, cornerRadius: 15, padding: 10)
        passField.placeholder = "Введите Пароль"
        passField.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    func createLoginButton() {
        addSubview(loginButt)
        loginButt.snp.makeConstraints { make in
            make.top.equalTo(passField.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
        }
        loginButt.addPulseAnimation()
    }
}
