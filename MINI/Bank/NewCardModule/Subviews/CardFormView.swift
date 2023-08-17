//
//  CardFormView.swift
//  MINI
//
//  Created by Yan Rybkin on 16.08.2023.
//

import UIKit
import SnapKit

fileprivate enum TextForm: String {
    case bank = "Введите название Банка"
    case bankDesc = "Банк, в котором была оформлена Ваша карта."
    case number = "Введите номер карты"
    case numberDesc = "Это 16 - 20 цифр на лицовой стороне Вашей карты."
    case cvv = "Введите CVV карты"
    case cvvDesc = "Это 3 цифры на обратной стороне Вашей карты."
}

final class CardFormView: UIView {
    
    weak var presenter: NewCardPresenterProtocol?
    
    private let bankStackView: UIStackView = {
        let view = UIStackView()
        view.setCustomAppearance(spacing: 15)
        return view
    }()
    
    private let numberStackView: UIStackView = {
        let view = UIStackView()
        view.setCustomAppearance(spacing: 15)
        return view
    }()
    
    private let cvvStackView: UIStackView = {
        let view = UIStackView()
        view.setCustomAppearance(spacing: 15)
        return view
    }()
    
    private lazy var bankTextView: FormTextView = {
        let view = FormTextView()
        view.addText(
            text: TextForm.bank.rawValue,
            description: TextForm.bankDesc.rawValue
        )
        return view
    }()
    
    private lazy var bankTextField: UITextField = {
        let field = UITextField()
        field.setCustomAppearance(
            withBorderColor: .tintMINI,
            cornerRadius: 15, padding: 10
        )
        field.delegate = self
        field.placeholder = "Bank Name"
        return field
    }()
    
    private lazy var numberTextView: FormTextView = {
        let view = FormTextView()
        view.addText(
            text: TextForm.number.rawValue,
            description: TextForm.numberDesc.rawValue
        )
        return view
    }()
    
    private lazy var numberTextField: UITextField = {
        let field = UITextField()
        field.setCustomAppearance(
            withBorderColor: .tintMINI,
            cornerRadius: 15, padding: 10
        )
        field.delegate = self
        field.placeholder = "1111 2222 3333 4444"
        return field
    }()
    
    private lazy var cvvTextView: FormTextView = {
        let view = FormTextView()
        view.addText(
            text: TextForm.cvv.rawValue,
            description: TextForm.cvvDesc.rawValue
        )
        return view
    }()
    
    private lazy var cvvTextField: UITextField = {
        let field = UITextField()
        field.setCustomAppearance(
            withBorderColor: .tintMINI,
            cornerRadius: 15, padding: 10
        )
        field.delegate = self
        field.placeholder = "***"
        field.isSecureTextEntry = true
        return field
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func safeAreaInsetsDidChange() {
        let stackView = UIStackView(arrangedSubviews: [
            bankStackView, numberStackView, cvvStackView
        ])
        
        stackView.setCustomAppearance(
            spacing: 40,
            distribution: .fillEqually
        )
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(safeAreaInsets.top)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalToSuperview().multipliedBy(0.45)
        }
    }
    
}

private extension CardFormView {
    
    func initialize() {
        bankStackView.addArrangedSubview(bankTextView)
        bankStackView.addArrangedSubview(bankTextField)
        
        numberStackView.addArrangedSubview(numberTextView)
        numberStackView.addArrangedSubview(numberTextField)
        
        cvvStackView.addArrangedSubview(cvvTextView)
        cvvStackView.addArrangedSubview(cvvTextField)
    }
    
}

extension CardFormView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case bankTextField: numberTextField.becomeFirstResponder()
        case numberTextField: cvvTextField.becomeFirstResponder()
        case cvvTextField: cvvTextField.resignFirstResponder()
        default: self.resignFirstResponder()
        }
        return true
    }
    
}
