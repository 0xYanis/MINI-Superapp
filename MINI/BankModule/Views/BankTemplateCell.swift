//
//  BankTemplateCell.swift
//  MINI
//
//  Created by Yan Rybkin on 17.04.2023.
//

import UIKit

final class BankTemplateCell: UITableViewCell {
    
    static let cellId = "BankTemplateCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BankTemplateCell {
    func initialize() {
        backgroundColor = .green
    }
}
