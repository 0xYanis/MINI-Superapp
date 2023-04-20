//
//  BankTemplateCell.swift
//  MINI
//
//  Created by Yan Rybkin on 20.04.2023.
//

import UIKit

final class BankTemplateCell: UICollectionViewCell {
    
    static let cellId = "BankTemplateCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BankTemplateCell {
    func initialize() {
        
    }
}
