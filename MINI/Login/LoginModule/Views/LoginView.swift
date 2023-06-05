//
//  LoginView.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    weak var presenter: LoginPresenterProtocol?
    
    private lazy var helloLabel = UILabel(text: "welcome_label".localized, font: .boldSystemFont(ofSize: 26), color: .none)
    let faceIDButton = UIButton(systemImage: "faceid", color: .systemOrange, size: 26)
    let nameField    = UITextField()
    let passField    = UITextField()
    let registerButt = UIButton()
    let loginButt    = UIButton(label: "login_button".localized, color: .systemOrange)
    
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
        createRegisterButton()
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
        nameField.setCustomAppearance(withBorderColor: .systemOrange, cornerRadius: 15, padding: 10)
        nameField.placeholder = "name_placeholder".localized
        
        addSubview(nameField)
        nameField.snp.makeConstraints { make in
            make.top.equalTo(helloLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.17)
        }
    }
    
    func createPassField() {
        passField.isSecureTextEntry = true
        passField.setCustomAppearance(withBorderColor: .systemOrange, cornerRadius: 15, padding: 10)
        passField.placeholder = "pass_placeholer".localized
        
        addSubview(passField)
        passField.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.17)
        }
    }
    
    func createRegisterButton() {
        registerButt.addTarget(
            self,
            action: #selector(registerButtonAction),
            for: .touchUpInside
        )
        registerButt.setTitle("Нет аккаунта?", for: .normal)
        registerButt.setTitleColor(.systemOrange, for: .normal)
        registerButt.addPulseAnimation()
        
        addSubview(registerButt)
        registerButt.snp.makeConstraints { make in
            make.top.equalTo(passField.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
        }
        
    }
    
    @objc func registerButtonAction() {
        presenter?.userWantRegister()
    }
    
    func createLoginButton() {
        addSubview(loginButt)
        loginButt.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.17)
        }
        loginButt.addPulseAnimation()
    }
    
    
}
