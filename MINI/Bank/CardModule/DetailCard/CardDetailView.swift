//
//  CardDetailView.swift
//  MINI
//
//  Created by Yan Rybkin on 26.04.2023.
//

import UIKit

final class CardDetailView: UIView {
    
    //MARK: Private properties
    private let cardView = UIView()
    private let cardLogo = UIImageView(image: UIImage(systemName: "globe"))
    private let cardAmount = UILabel(
        text: "$1,200", font: .boldSystemFont(ofSize: 20), color: .white)
    private let cardNumber = UILabel(
        text: "*4631", font: .systemFont(ofSize: 16), color: .gray)
    
    static let cellId = "CardDetailViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

private extension CardDetailView {
    func initialize() {
        backgroundColor = .clear
        createCardView()
        createCardLogo()
        createCardNumber()
        createCardAmount()
    }
    func createCardView() {
        cardView.backgroundColor = .systemGreen
        cardView.roundCorners(radius: 20)
        addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview()
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
