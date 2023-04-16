//
//  LoginView.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    private let helloLabel = UILabel(text: "Hello!", font: .boldSystemFont(ofSize: 20), color: .black)
    private let nameField = UITextField()
    private let passField = UITextField()
    private let loginButt = UIButton(label: "Login", color: .systemCyan, height: 30, width: 90)
    
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
        
    }
    func createNameField() {
        
    }
    func createPassField() {
        
    }
    func createLoginButton() {
        
    }
}
