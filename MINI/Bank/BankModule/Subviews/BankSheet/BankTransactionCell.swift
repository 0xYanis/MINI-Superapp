//
//  BankTransactionCell.swift
//  MINI
//
//  Created by Yan Rybkin on 18.04.2023.
//

import UIKit
import SnapKit
import SDWebImage

final class BankTransactionCell: UITableViewCell {
    
    private let iconView = UIImageView(cornerRadius: 15)
    private let transactionLabel = UILabel(
        text: "Wallmart: apples, cola, glock-17",
        font: .systemFont(ofSize: 16),
        numberOfLines: 2,
        color: .none)
    private let dateLabel = UILabel(
        text: "19 Apr 2023",
        font: .systemFont(ofSize: 14),
        color: .gray)
    private let costLabel = UILabel(
        text: "-$78",
        font: .boldSystemFont(ofSize: 16),
        color: .none)
    private let cardLabel = UILabel(
        text: "*4631",
        font: .systemFont(ofSize: 14),
        color: .none)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public method
    func configure(with transaction: BankTransactionEntity) {
        iconView.sd_setImage(with: URL(string: transaction.icon ?? ""))
        transactionLabel.text = transaction.name + ": " + transaction.notes
        dateLabel.text = transaction.date.formattedDateString(dateFormat: "d MMM, yyyy")
        costLabel.text = "-\(transaction.cost)"
        cardLabel.text = "*\(transaction.cardNumber)"
    }
    
}

extension BankTransactionCell {
    
    func initialize() {
        backgroundColor = .backMINI
        selectionStyle = .none
        createIcon()
        createTransaction()
        createDate()
        createCost()
        createCard()
    }
    
    func createIcon() {
        iconView.contentMode = .scaleAspectFill
        addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(60)
        }
    }
    
    func createTransaction() {
        addSubview(transactionLabel)
        transactionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalTo(iconView.snp.right).offset(10)
            make.width.equalTo(frame.width * 0.7)
        }
    }
    
    func createDate() {
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.left.equalTo(iconView.snp.right).offset(10)
        }
    }
    
    func createCost() {
        addSubview(costLabel)
        costLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(20)
        }
    }
    
    func createCard() {
        addSubview(cardLabel)
        cardLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
}
