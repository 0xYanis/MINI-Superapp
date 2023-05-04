//
//  AviaResultsCell.swift
//  MINI
//
//  Created by Yan Rybkin on 04.05.2023.
//

import UIKit

final class AviaResultsCell: UITableViewCell {
    
    static let cellId = "AviaResultsCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AviaResultsCell {
    func initialize() {
        backgroundColor = .gray
    }
}
