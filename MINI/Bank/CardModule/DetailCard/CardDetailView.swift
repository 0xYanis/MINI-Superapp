//
//  CardDetailView.swift
//  MINI
//
//  Created by Yan Rybkin on 26.04.2023.
//

import UIKit

final class CardDetailView: UIView {
    
    //MARK: Private properties
    private lazy var cardView = UIView()
    private lazy var cardLogo = UIImageView(image: UIImage(systemName: "globe"))
    private lazy var cardNumber = UILabel(
        text: "1234 5678 9123 4567", font: .systemFont(ofSize: 28), color: .white)
    
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
        cardLogo.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(35)
            make.width.height.equalTo(45)
        }
    }
    func createCardNumber() {
        cardView.addSubview(cardNumber)
        cardNumber.layer.shadowColor = UIColor.black.cgColor
        cardNumber.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardNumber.layer.shadowRadius = 2.0
        cardNumber.layer.shadowOpacity = 0.5
        cardNumber.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
    }
}
