//
//  FormCell.swift
//  MINI
//
//  Created by Yanis on 23.10.2023.
//

import UIKit
import SnapKit


protocol FormTextDelegate: AnyObject {
    func textFieldDidReturn(_ text: String, from fieldTag: Int)
}

final class FormCell: UITableViewCell {
    
    // MARK: - Public properties
    
    weak var delegate: FormTextDelegate?
    
    // MARK: - Private properties
    
    private var titleLabel = UILabel()
    private var textField  = UITextField()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Public methods
    
    public func hideKeyboard() {
        textField.resignFirstResponder()
    }
    
    public func configure(with data: FormField, tag: Int) {
        textField.tag = tag
        titleLabel.text = data.title
        textField.placeholder = data.placeholder
    }
    
    // MARK: - Private methods
    
    private func initialize() {
        selectionStyle = .none
        titleLabel.textColor = .secondaryLabel
        titleLabel.font = .systemFont(ofSize: 10)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(5)
        }
        
        textField.delegate = self
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(5)
        }
    }
    
}

// MARK: - UITextFieldDelegate

extension FormCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        delegate?.textFieldDidReturn(text, from: textField.tag)
        return true
    }
    
}

