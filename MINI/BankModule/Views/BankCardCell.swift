//
//  BankCardCell.swift
//  MINI
//
//  Created by Yan Rybkin on 17.04.2023.
//

import UIKit

final class BankCardCell: UICollectionViewCell {
    
    static let cellId = "BankCardCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BankCardCell {
    func initialize() {
        backgroundColor = .red
    }
}
