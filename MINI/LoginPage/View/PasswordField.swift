//
//  PasswordField.swift
//  MINI
//
//  Created by Yan Rybkin on 05.04.2023.
//

import UIKit

class PasswordField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PasswordField {
    func initialize() {
        isSecureTextEntry = true
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 5
    }
}
