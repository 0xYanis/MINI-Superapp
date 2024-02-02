//
//  OrderPriceView.swift
//  MINI
//
//  Created by Yan Rybkin on 21.09.2023.
//

import UIKit
import SnapKit

// MARK: - OrderPriceViewDelegate

protocol OrderPriceViewDelegate: AnyObject {
    func updateOrderPriceViewSize()
    func didTapBuy()
}

final class OrderPriceView: UIView {
    
    // MARK: - Public properties
    
    public weak var delegate: OrderPriceViewDelegate?
    
    // MARK: - Private properties
    
    private var isSmall: Bool = true
    
    private let tapGesture     = UITapGestureRecognizer()
    private let containterView = UIView()
    private let stackView      = UIStackView()
    private let countLabel     = UILabel()
    private let nextLabel      = UILabel()
    private let priceButton    = UIButton()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Public methods
    
    public func updateData(quantity: Int, price: String) {
        let word = "товар"
        let pluralize = word.pluralize(count: quantity)
        countLabel.text = "Всего: \(quantity) \(pluralize)"
        priceButton.setTitle(price, for: .normal)
    }
    
    public func updateButtonSize() {
        priceButton.snp.removeConstraints()
        isSmall = !isSmall
        UIView.animate(withDuration: 0.2) { [weak self] in
            if self?.isSmall == true {
                self?.setSmallSizeButton()
                self?.removeContainer()
            } else {
                self?.setFullSizeButton()
                self?.addContainer()
            }
            self?.layoutIfNeeded()
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.stackView.alpha = self.isSmall ? 0.0 : 1.0
        }
    }
    
}

// MARK: - Private methods

private extension OrderPriceView {
    
    func initialize() {
        tapGesture.addTarget(self, action: #selector(didTapped))
        backgroundColor = .clear
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.secondaryLabel.cgColor
        createBlurEffect(blurStyle: .regular)
        createPriceButton()
        roundCorners(radius: 15)
    }
    
    @objc func didTapped() {
        delegate?.didTapBuy()
    }
    
    func addContainer() {
        containterView.addGestureRecognizer(tapGesture)
        addSubview(containterView)
        containterView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        addContainterSubviews()
    }
    
    func removeContainer() {
        stackView.snp.removeConstraints()
        stackView.removeFromSuperview()
        containterView.snp.removeConstraints()
        containterView.removeFromSuperview()
        containterView.removeGestureRecognizer(tapGesture)
    }
    
    func addContainterSubviews() {
        countLabel.font = .systemFont(ofSize: 17)
        
        nextLabel.text = "Продолжить оформление заказа?"
        nextLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        nextLabel.textColor = .gray
        
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(nextLabel)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        
        containterView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(16)
        }
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
    
    @objc func priceButtonAction() {
        delegate?.updateOrderPriceViewSize()
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
    
}
