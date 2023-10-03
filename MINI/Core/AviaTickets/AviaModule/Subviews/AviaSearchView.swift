//
//  AviaSearchView.swift
//  MINI
//
//  Created by Yanis on 03.10.2023.
//

import UIKit
import SnapKit

final class AviaSearchView: UICollectionReusableView {
    
    private var fromTextField = UITextField()
    private var toTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .midnightBlue.darker.darker
        
        fromTextField.backgroundColor = .systemGray4
        fromTextField.placeholder = "Поиск авиабилетов"
        addSubview(fromTextField)
        fromTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(35)
        }
        fromTextField.roundCorners(radius: 8)
        appearance(fromTextField, padding: 10)
        
        toTextField.backgroundColor = .systemGray4
        toTextField.placeholder = "Поиск авиабилетов"
        addSubview(toTextField)
        toTextField.snp.makeConstraints { make in
            make.top.equalTo(fromTextField.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(35)
        }
        toTextField.roundCorners(radius: 8)
        appearance(toTextField, padding: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func appearance(_ textField: UITextField, padding: CGFloat) {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        let rightPaddingView = UIView(frame: CGRect(x: frame.width - padding, y: 0, width: padding, height: frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        textField.rightView = rightPaddingView
        textField.rightViewMode = .always
    }
    
}
