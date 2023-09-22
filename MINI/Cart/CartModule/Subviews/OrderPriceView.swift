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
    
    private let tapGesture  = UITapGestureRecognizer()
    private let containterView = UIView()
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

// MARK: - Private methods

private extension OrderPriceView {
    
    func initialize() {
        tapGesture.addTarget(self, action: #selector(didTapped))
        backgroundColor = .clear
        createBlurEffect(blurStyle: .systemUltraThinMaterialDark)
        createPriceButton()
    }
    
    func addContainer() {
        containterView.addGestureRecognizer(tapGesture)
        containterView.backgroundColor = .red
        addSubview(containterView)
        containterView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
        }
    }
    
    func removeContainer() {
        containterView.snp.removeConstraints()
        containterView.removeGestureRecognizer(tapGesture)
    }
    
    @objc func didTapped() {
        delegate?.didTapBuy()
    }
    
}

// MARK: - Price button private methods

private extension OrderPriceView {
    
    func createPriceButton() {
        priceButton.addTarget(self, action: #selector(priceButtonAction), for: .touchUpInside)
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
        isSmall = !isSmall
        UIView.animate(withDuration: 0.2, delay: 0) { [weak self] in
            if self?.isSmall == true {
                self?.setSmallSizeButton()
                self?.removeContainer()
            } else {
                self?.setFullSizeButton()
                self?.addContainer()
            }
            self?.layoutIfNeeded()
        }
        
        delegate?.priceButtonAction()
    }
    
    
}
