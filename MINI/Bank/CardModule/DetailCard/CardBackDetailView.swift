//
//  CardBackDetailView.swift
//  MINI
//
//  Created by Yan Rybkin on 06.06.2023.
//

import UIKit
import SkeletonView

final class CardBackDetailView: UIView {
    
    private lazy var cardView    = UIView()
    private lazy var lineView    = UIView()
    private lazy var cvvLineView = UIView()
    private lazy var cvvLabel    = UILabel(
        text: "CVV: 123",
        font: .systemFont(ofSize: 18),
        numberOfLines: 1,
        color: .black
    )
    private lazy var bankLabel   = UILabel(
        text: "BANK",
        font: .boldSystemFont(ofSize: 28),
        color: .silver
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: BankCardEntity) {
        cardView.backgroundColor = UIColor(named: data.cardColor)
        cvvLabel.text = data.cvv
        bankLabel.text = data.bankName
    }
}

private extension CardBackDetailView {
    func initialize() {
        createCardView()
        createLineView()
        createCvvlineView()
        createCvvLabel()
        createBankLabel()
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
    
    func createLineView() {
        lineView.backgroundColor = .black
        cardView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
            make.top.equalToSuperview().inset(20)
        }
    }
    
    func createCvvlineView() {
        cvvLineView.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
        cardView.addSubview(cvvLineView)
        cvvLineView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.15)
            make.centerY.equalToSuperview()
        }
    }
    
    func createCvvLabel() {
        cvvLineView.addSubview(cvvLabel)
        cvvLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }
    }
    
    func createBankLabel() {
        cardView.addSubview(bankLabel)
        bankLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
        }
    }
}
