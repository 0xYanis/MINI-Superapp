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
    case cvvDesc = "Это 3 секретные цифры на обратной стороне Вашей карты."
}

final class CardFormView: UIView {
    
    weak var presenter: NewCardPresenterProtocol?
    
    private let stackView = UIStackView()
    
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
    
}

private extension CardFormView {
    
    func initialize() {
        stackView.addArrangedSubview(bankTextView)
        stackView.addArrangedSubview(bankTextField)
        
        stackView.addArrangedSubview(numberTextView)
        stackView.addArrangedSubview(numberTextField)
        
        stackView.addArrangedSubview(cvvTextView)
        stackView.addArrangedSubview(cvvTextField)
        
        stackView.spacing = 14
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
    }
    
}
