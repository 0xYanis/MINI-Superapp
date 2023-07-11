//
//  CardDetailView.swift
//  MINI
//
//  Created by Yan Rybkin on 26.04.2023.
//

import UIKit
import SkeletonView

final class CardDetailView: UIView {
    
    //MARK: Private properties
    private lazy var cardView   = UIView()
    private lazy var cardLogo   = UIImageView(image: UIImage(systemName: "globe"))
    private lazy var bankLabel  = UILabel(
        text: "BANK",
        font: .boldSystemFont(ofSize: 28),
        color: .silver
    )
    private lazy var cardHolder = UILabel(
        text: "Bob",
        font: .systemFont(ofSize: 18),
        color: .silver
    )
    private lazy var cardNumber = UILabel(
        text: "1234 5678 9123 4567",
        font: .systemFont(ofSize: 24),
        color: .silver
    )
    private lazy var expirationDate = UILabel(
        text: "1.1.1",
        font: .systemFont(ofSize: 18),
        color: .silver
    )
    
    static let cellId = "CardDetailViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: BankCardEntity) {
        cardView.backgroundColor = UIColor(named: data.cardColor)
        cardLogo.image = UIImage(named: data.logo)
        bankLabel.text = data.bankName
        cardHolder.text = data.holderName
        expirationDate.text = data.expirationDate
        cardNumber.text = data.number.formatAsCardNumber()
    }
    
}

private extension CardDetailView {
    func initialize() {
        backgroundColor = .clear
        createCardView()
        createCardLogo()
        createBankLabel()
        createCardNumber()
        createHolderName()
        createExperatonDate()
    }
    func createCardView() {
        cardView.backgroundColor = .systemGreen
        cardView.radiusAndShadow(radius: 20, shadowSize: 10)
        addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview()
        }
    }
    func createCardLogo() {
        cardView.addSubview(cardLogo)
        cardLogo.contentMode = .scaleAspectFit
        cardLogo.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(35)
            make.top.equalToSuperview().inset(15)
            make.width.height.equalTo(70)
        }
    }
    func createBankLabel() {
        cardView.addSubview(bankLabel)
        bankLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(35)
        }
    }
    
    func createHolderName() {
        cardView.addSubview(cardHolder)
        cardHolder.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(35)
            make.bottom.equalToSuperview().inset(15)
        }
    }
    
    func createExperatonDate() {
        cardView.addSubview(expirationDate)
        expirationDate.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(35)
            make.bottom.equalToSuperview().inset(15)
        }
    }
    
    func createCardNumber() {
        cardView.addSubview(cardNumber)
        cardNumber.layer.shadowColor = UIColor.black.cgColor
        cardNumber.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardNumber.layer.shadowRadius = 3.0
        cardNumber.layer.shadowOpacity = 0.9
        cardNumber.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
    }
    
}
