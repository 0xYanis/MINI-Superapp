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
    
    private let textPadding = UIEdgeInsets(
        top: 0,
        left: 10,
        bottom: 0,
        right: 30
    )
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}

private extension PasswordField {
    func initialize() {
        clearsOnBeginEditing = true
        textContentType = .password
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 5
    }
}
