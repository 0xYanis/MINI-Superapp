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
    private let nameLabel = UILabel(text: "Name", font: .systemFont(ofSize: 16), color: .black)
    private let passLabel = UILabel(text: "Password", font: .systemFont(ofSize: 16), color: .black)
    private let nameField = UITextField()
    private let passField = UITextField()
    private let loginButt = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoginView {
    func initialize() {
        
    }
}
