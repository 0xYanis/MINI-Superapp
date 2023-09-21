//
//  OrderPriceView.swift
//  MINI
//
//  Created by Yan Rybkin on 21.09.2023.
//

import UIKit
import SnapKit

protocol OrderPriceViewDelegate: AnyObject {
    func priceButtonAction()
    func didTapBuy()
}

final class OrderPriceView: UIView {
    
    weak var delegate: OrderPriceViewDelegate?
    
    private var isSmall: Bool = true
    
    private let priceButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func updatePrice(_ price: String) {
        priceButton.setTitle(price, for: .normal)
    }
    
}

private extension OrderPriceView {
    
    func initialize() {
        backgroundColor = .clear
        createBlurEffect(blurStyle: .systemUltraThinMaterialDark)
        createPriceButton()
    }
    
    func createPriceButton() {
        priceButton.addTarget(self, action: #selector(priceButtonAction), for: .touchUpInside)
        priceButton.setTitle("$399.4", for: .normal)
        priceButton.backgroundColor = .systemOrange
        priceButton.roundCorners(radius: 10)
        priceButton.addPulseAnimation()
        addSubview(priceButton)
        setSmallSizeButton()
    }
    
    func setFullSizeButton() {
        priceButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.width.equalTo(90)
        }
    }
    
    func setSmallSizeButton() {
        priceButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func priceButtonAction() {
        priceButton.snp.removeConstraints()
        
        if isSmall {
            UIView.animate(withDuration: 0.2, delay: 0) { [weak self] in
                self?.setFullSizeButton()
                self?.layoutIfNeeded()
            }
            isSmall = false
        } else {
            UIView.animate(withDuration: 0.2, delay: 0) { [weak self] in
                self?.setSmallSizeButton()
                self?.layoutIfNeeded()
            }
            isSmall = true
        }
        delegate?.priceButtonAction()
    }
    
}
