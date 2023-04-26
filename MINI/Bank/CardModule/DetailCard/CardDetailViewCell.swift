//
//  CardDetailViewCell.swift
//  MINI
//
//  Created by Yan Rybkin on 26.04.2023.
//

import UIKit

final class CardDetailViewCell: UITableViewCell {
    
    static let cellId = "CardDetailViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

private extension CardDetailViewCell {
    func initialize() {
        backgroundColor = .green
    }
}
