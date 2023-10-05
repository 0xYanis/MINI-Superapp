//
//  CartTagCell.swift
//  MINI
//
//  Created by Yanis on 05.10.2023.
//

import UIKit

final class CartTagCell: UITableViewCell {
    
    weak var pickerDelegate: UITagPickerDelegate?
    
    private let pickerView = UITagPickerView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with tags: [String]) {
        pickerView.pickerDelegate = pickerDelegate
        pickerView.configure(with: tags)
    }
    
}
