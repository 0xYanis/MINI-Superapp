//
//  RegisterView.swift
//  MINI
//
//  Created by Yan Rybkin on 06.06.2023.
//

import UIKit
import SnapKit

protocol RegisterViewDelegate: AnyObject {
    func userDidTapRegister(name: String, pass: String, secondPass: String)
}

final class RegisterView: UIView {
    
    weak var delegate: RegisterViewDelegate?
    
    private let nameField       = UITextField()
    private let passField       = UITextField()
    private let secondPassField = UITextField()
    private let helloLabel = UILabel(
        text: "welcomeReg_label".localized,
        font: .boldSystemFont(ofSize: 26),
        color: .tintMINI)
    private let regButton = UIButton(
        label: "login_button".localized,
        color: .tintMINI)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func tapOffTheField() {
        nameField.resignFirstResponder()
        passField.resignFirstResponder()
        secondPassField.resignFirstResponder()
    }
    
}

// MARK: - UITextFieldDelegate

extension RegisterView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:
            passField.becomeFirstResponder()
        case passField:
            secondPassField.becomeFirstResponder()
        default:
            secondPassField.resignFirstResponder()
            userDidTapRegister()
        }
        return true
    }
    
}

// MARK: - Private methods

private extension RegisterView {
    
    func initialize() {
        backgroundColor = .clear
        roundCorners(radius: 30)
        createHelloLabel()
        createNameField()
        createPassField()
        createSecondPassField()
        createRegButton()
    }
    
    func createHelloLabel() {
        addSubview(helloLabel)
        helloLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(20)
        }
    }
    
    func createNameField() {
        nameField.setCustomAppearance(withBorderColor: .tintMINI, cornerRadius: 15, padding: 10)
        nameField.placeholder = "name_placeholder".localized
        nameField.delegate = self
        
        addSubview(nameField)
        nameField.snp.makeConstraints { make in
            make.top.equalTo(helloLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.13)
        }
    }
    
    func createPassField() {
        passField.isSecureTextEntry = true
        passField.setCustomAppearance(withBorderColor: .tintMINI, cornerRadius: 15, padding: 10)
        passField.placeholder = "pass_placeholer".localized
        passField.delegate = self
        
        addSubview(passField)
        passField.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.13)
        }
    }
    
    func createSecondPassField() {
        secondPassField.isSecureTextEntry = true
        secondPassField.setCustomAppearance(withBorderColor: .tintMINI, cornerRadius: 15, padding: 10)
        secondPassField.placeholder = "secondPass_placeholer".localized
        secondPassField.delegate = self
        
        addSubview(secondPassField)
        secondPassField.snp.makeConstraints { make in
            make.top.equalTo(passField.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.13)
        }
    }
    
    func createRegButton() {
        regButton.addTarget(self, action: #selector(userDidTapRegister), for: .touchUpInside)
        regButton.addPulseAnimation()
        
        addSubview(regButton)
        regButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.13)
        }
    }
    
    @objc func userDidTapRegister() {
        guard
            let name = nameField.text,
            let pass = passField.text,
            let secondPass = secondPassField.text
        else { return }
        delegate?.userDidTapRegister(name: name, pass: pass, secondPass: secondPass)
    }
    
}
