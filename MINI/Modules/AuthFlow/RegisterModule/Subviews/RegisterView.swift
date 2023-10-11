//
//  RegisterView.swift
//  MINI
//
//  Created by Yan Rybkin on 06.06.2023.
//

import UIKit
import SnapKit

final class RegisterView: UIView {
    
    let nameField       = UITextField()
    let passField       = UITextField()
    let secondPassField = UITextField()
    
    private lazy var helloLabel = UILabel(
        text: "welcomeReg_label".localized,
        font: .boldSystemFont(ofSize: 26),
        color: .tintMINI
    )
    let regButton  = UIButton(
        label: "login_button".localized,
        color: .tintMINI
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

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
        
        addSubview(secondPassField)
        secondPassField.snp.makeConstraints { make in
            make.top.equalTo(passField.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.13)
        }
    }
    
    func createRegButton() {
        regButton.addPulseAnimation()
        
        addSubview(regButton)
        regButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.13)
        }
    }
    
    
}
