//
//  BankCardCell.swift
//  MINI
//
//  Created by Yan Rybkin on 20.04.2023.
//

import UIKit
import SnapKit

final class BankCardCell: UICollectionViewCell {
    
    static let cellId = "BankCardCell"
    
    // MARK: - Public method
    func configure() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let cardView = UIView()
    private let cardLogo = UIImageView(image: UIImage(systemName: "globe"))
    private let cardAmount = UILabel(text: "$1,200", font: .boldSystemFont(ofSize: 20), color: .white)
    private let cardNumber = UILabel(text: "*4631", font: .systemFont(ofSize: 16), color: .gray)
}

private extension BankCardCell {
    func initialize() {
        createCardView()
        createCardLogo()
        createCardNumber()
        createCardAmount()
    }
    func createCardView() {
        cardView.backgroundColor = UIColor(named: "cardColor")
        cardView.roundCorners(radius: 10)
        addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(20)
        }
    }
    func createCardLogo() {
        cardView.addSubview(cardLogo)
        cardLogo.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(18)
            make.width.equalTo(20)
        }
    }
    func createCardNumber() {
        cardView.addSubview(cardNumber)
        cardNumber.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview().inset(18)
        }
    }
    func createCardAmount() {
        cardView.addSubview(cardAmount)
        cardAmount.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(18)
            make.centerY.equalToSuperview().offset(18)
        }
    }
}
