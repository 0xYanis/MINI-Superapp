//
//  TransactionCell.swift
//  MINI
//
//  Created by Yanis on 10.10.2023.
//

import UIKit

final class TransactionCell: UITableViewCell {
    
    private let headLabel = UILabel()
    private let footLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(head: String, foot: String) {
        headLabel.text = head
        footLabel.text = foot
    }
    
    private func initialize() {
        headLabel.textAlignment = .left
        headLabel.font = .systemFont(ofSize: UIFont.smallSystemFontSize)
        headLabel.textColor = .secondaryLabel
        
        footLabel.textAlignment = .left
        footLabel.numberOfLines = 0
        footLabel.font = .systemFont(ofSize: UIFont.labelFontSize)
        footLabel.textColor = .label
    }
    
    private func setConstraints() {
        contentView.addSubview(headLabel)
        headLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        contentView.addSubview(footLabel)
        footLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
}
