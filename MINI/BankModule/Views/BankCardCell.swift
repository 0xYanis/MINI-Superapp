//
//  BankCardCell.swift
//  MINI
//
//  Created by Yan Rybkin on 17.04.2023.
//

import UIKit

final class BankCardCell: UITableViewCell {
    
    static let cellId = "BankCardCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BankCardCell {
    func initialize() {
        
    }
}
