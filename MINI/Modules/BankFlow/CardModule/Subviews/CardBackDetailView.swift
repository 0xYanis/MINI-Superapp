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
    private lazy var cvvButton   = UIButton()
    private lazy var bankLabel   = UILabel(
        text: "BANK",
        font: .boldSystemFont(ofSize: 28),
        color: .silver
    )
    
    private var isTappedCvv: Bool = false
    private var cvvNumber: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: Card) {
        cardView.backgroundColor = UIColor(named: data.cardColor)
        cvvNumber = data.cvv
        bankLabel.text = data.bankName
    }
    
}

private extension CardBackDetailView {
    func initialize() {
        createCardView()
        createLineView()
        createCvvlineView()
        createCvvButton()
        createBankLabel()
    }
    
    func createCardView() {
        cardView.backgroundColor = .systemGreen
        cardView.radiusAndShadow(radius: 20, shadowSize: 10)
        
        addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(25)
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
    
    func createCvvButton() {
        cvvButton.setTitle("***", for: .normal)
        cvvButton.tintColor = .black
        cvvButton.titleLabel?.font = .systemFont(ofSize: 18)
        cvvButton.addTarget(
            self,
            action: #selector(cvvAction),
            for: .touchUpInside
        )
        
        cvvLineView.addSubview(cvvButton)
        cvvButton.snp.makeConstraints { make in
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
    
    @objc func cvvAction() {
        isTappedCvv.toggle()
        isTappedCvv ? cvvButton.setTitle(cvvNumber, for: .normal) : cvvButton.setTitle("***", for: .normal)
        cvvButtonAnimation(cvvButton)
    }
    
    func cvvButtonAnimation(_ button: UIButton) {
        button.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(
            withDuration: 0.6,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 6.0,
            options: .allowUserInteraction,
            animations: {
            button.transform = .identity
        })
    }
    
}

