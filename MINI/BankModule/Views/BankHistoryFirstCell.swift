//
//  BankHistoryFirstCell.swift
//  MINI
//
//  Created by Yan Rybkin on 19.04.2023.
//

import UIKit
import SnapKit

final class BankHistoryFirstCell: UITableViewCell {
    
    static let cellId = "BankHistoryFirstCell"
    
    private let historyLabel = UILabel(text: "Transaction History", font: .boldSystemFont(ofSize: 22), color: .black)
    private let searchButton = UIButton(systemImage: "search", color: .black, size: 22)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BankHistoryFirstCell {
    func initialize() {
        createLabel()
        createSearch()
    }
    func createLabel() {
        addSubview(historyLabel)
        historyLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16)
        }
    }
    func createSearch() {
        addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
    }
}
