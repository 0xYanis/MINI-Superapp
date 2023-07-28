//
//  BankCardCell.swift
//  MINI
//
//  Created by Yan Rybkin on 20.04.2023.
//

import UIKit
import SnapKit
import SkeletonView

final class BankCardCell: UICollectionViewCell, CellConfProtocol {
    
    //MARK: Private properties
    private lazy var cardView = UIView()
    private lazy var cardLogo = UIImageView()
    private lazy var cardAmount = UILabel(
        text: "",
        font: .boldSystemFont(ofSize: 20),
        color: .white
    )
    private lazy var cardNumber = UILabel(
        text: "",
        font: .systemFont(ofSize: 16),
        color: .white
    )
    
    //MARK: Public properties
    static let cellId = "BankCardCell"
    
    // MARK: - Public methods
    func configure(with card: BankCardEntity) {
        cardView.backgroundColor = UIColor(named: card.cardColor)
        cardLogo.image = UIImage(named: card.logo)
        cardAmount.text = card.currency.getCurrencySymbol() + "\(card.amount)"
        cardNumber.text = "*" + card.number.suffix(4)
    }
    
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
        isSkeletonable = true
        skeletonCornerRadius = 10
        createCardView()
        createCardLogo()
        createCardNumber()
        createCardAmount()
    }
    func createCardView() {
        cardView.roundCorners(radius: 10)
        addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
    func createCardLogo() {
        let image = UIImage()
        cardLogo.image = image
        cardLogo.contentMode = .scaleAspectFit
        cardView.addSubview(cardLogo)
        cardLogo.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.left.equalToSuperview().inset(18)
            make.width.height.equalTo(40)
        }
    }
    func createCardNumber() {
        cardView.addSubview(cardNumber)
        cardNumber.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    func createCardAmount() {
        cardView.addSubview(cardAmount)
        cardAmount.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
        }
    }
    
}
