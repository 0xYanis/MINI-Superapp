//
//  BankTemplateSet.swift
//  MINI
//
//  Created by Yan Rybkin on 17.04.2023.
//

import UIKit

final class BankTemplateSet: UITableViewCell {
    
    static let cellId = "BankTemplateSet"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BankTemplateSet {
    func initialize() {
        backgroundColor = .green
    }
}
