//
//  LoginView.swift
//  MINI
//
//  Created by Yan Rybkin on 05.04.2023.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 14)
        label.text = "Login"
        return label
    }()
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 14)
        label.text = "Password"
        return label
    }()
}

private extension LoginView {
    func initialize() {
        backgroundColor = .white
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(loginLabel)
        stackView.addArrangedSubview(passwordLabel)
    }
}
