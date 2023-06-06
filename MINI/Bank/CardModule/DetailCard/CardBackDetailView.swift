//
//  CardBackDetailView.swift
//  MINI
//
//  Created by Yan Rybkin on 06.06.2023.
//

import UIKit
import SkeletonView

final class CardBackDetailView: UIView {
    
    private lazy var cardView = UIView()
    private lazy var lineView = UIView()
    private lazy var cvvLabel = UILabel(
        text: "CVV: 123",
        font: .systemFont(ofSize: 18),
        numberOfLines: 1,
        color: .black
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
    }
}

private extension CardBackDetailView {
    func initialize() {
        createCardView()
        createCvvLabel()
        createLineView()
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
    
    func createCvvLabel() {
        
        
        addSubview(cvvLabel)
        cvvLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(35)
            make.right.equalToSuperview().inset(50)
        }
    }
    
    func createLineView() {
        lineView.backgroundColor = .silver
        addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.bottom.equalToSuperview().inset(40)
        }
    }
}
