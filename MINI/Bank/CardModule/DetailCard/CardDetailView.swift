//
//  CardDetailView.swift
//  MINI
//
//  Created by Yan Rybkin on 26.04.2023.
//

import UIKit

final class CardDetailView: UITableViewCell {
    
    static let cellId = "CardDetailView"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

private extension CardDetailView {
    func initialize() {
        backgroundColor = .green
    }
}
