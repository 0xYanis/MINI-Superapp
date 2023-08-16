//
//  CardFormView.swift
//  MINI
//
//  Created by Yan Rybkin on 16.08.2023.
//

import UIKit
import SnapKit

final class CardFormView: UIView {
    
    weak var presenter: NewCardPresenterProtocol?
    
    private lazy var bankTextView: FormTextView = {
        let view = FormTextView()
        view.addText(
            text: "Введите название Банка",
            description: "Банк, в котором была оформлена Ваша карта"
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
            text: "Введите номер карты",
            description: "Это 16 - 20 цифр на лицовой стороне Вашей карты"
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
            text: "Введите CVV карты",
            description: "Это 3 цифры на обороте Вашей карты"
        )
        return view
    }()
    
    private lazy var cvvTextField: UITextField = {
        let field = UITextField()
        field.setCustomAppearance(
            withBorderColor: .tintMINI,
            cornerRadius: 15, padding: 10
        )
        field.placeholder = "1111 2222 3333 4444"
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
        
    }
    
}
