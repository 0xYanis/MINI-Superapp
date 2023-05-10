//
//  AviaResultsCell.swift
//  MINI
//
//  Created by Yan Rybkin on 04.05.2023.
//

import UIKit

final class AviaResultsCell: UITableViewCell {
    func configure() {
        
    }
    
    private let nameLabel = UILabel(
        text: "Country",
        font: .systemFont(ofSize: 20),
        color: .white
    )
    private let detailLabel = UILabel(
        text: "Ticket to that country",
        font: .systemFont(ofSize: 18),
        color: .systemGray6
    )
    private let priceLabel = UILabel(
        text: "$4.99",
        font: .systemFont(ofSize: 20),
        color: .green
    )
    private let dateLabel = UILabel(
        text: "May 25",
        font: .systemFont(ofSize: 18),
        color: .systemGray6
    )
    private var collectionView: UICollectionView!

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
        backgroundColor = .systemGreen
    }
    
    
    
    func createCollectionView() {
        
    }
}
