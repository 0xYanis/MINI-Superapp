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
        
    }
}
