//
//  PurchaseCell.swift
//  MINI
//
//  Created by Yan Rybkin on 06.09.2023.
//

import UIKit
import SnapKit

final class PurchaseCell: UITableViewCell {
    
    private let container = UIView()
    private let purchaseImage: UIImageView = {
        let view = UIImageView(cornerRadius: 15)
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "AppIcon")
        return view
    }()
    private let purchaseType = UILabel(
        text: "(Товары)",
        font: .boldSystemFont(ofSize: UIFont.systemFontSize),
        color: .secondaryLabel)
    private let purchaseLabel = UILabel(
        text: "Кроссовки",
        font: .systemFont(ofSize: UIFont.systemFontSize),
        color: .label)
    private let subLabel = UILabel(
        text: "Удобные кроссовки на каждый день, демисезон",
        font: .systemFont(ofSize: UIFont.systemFontSize),
        numberOfLines: 3,
        color: .secondaryLabel)
    private let priceLabel = UILabel(
        text: "$96.99",
        font: .boldSystemFont(ofSize: 16),
        color: .systemOrange)
    private let quantityLabel = UILabel(
        text: "Количество: 1",
        font: .systemFont(ofSize: 13),
        color: .secondaryLabel)
    private let additionalButton = UIButton(
        systemImage: "ellipsis",
        color: .label,
        size: 25)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
        addSubviews(to: container)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with data: Purchase) {
        purchaseImage.image = UIImage(named: "AppIcon")
        purchaseLabel.text = data.name
        subLabel.text = data.description
        purchaseType.text = data.type.rawValue
        priceLabel.text = "$ \(data.price)"
        quantityLabel.text = "Количество: \(data.quantity)"
    }
    
}

private extension PurchaseCell {
    
    func initialize() {
        selectionStyle = .none
        backgroundColor = .clear
        
        container.backgroundColor = .systemBackground
        addSubview(container)
        container.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(12)
        }
        container.roundCorners(radius: 10)
        
        additionalButton.menu = additionalMenu
        additionalButton.showsMenuAsPrimaryAction = true
    }
    
    func addSubviews(to view: UIView) {
        view.addSubview(purchaseImage)
        view.addSubview(purchaseLabel)
        view.addSubview(purchaseType)
        view.addSubview(subLabel)
        view.addSubview(priceLabel)
        view.addSubview(quantityLabel)
        view.addSubview(additionalButton)
    }
    
    var additionalMenu: UIMenu {
        return UIMenu(children: [
            changeQuantityAction,
            addToFavoriteAction
        ])
    }
    
    var changeQuantityAction: UIAction {
        return UIAction(
            title: "Изменить количество",
            image: .init(systemName: "plusminus")
        ) { _ in
            
        }
    }
    
    var addToFavoriteAction: UIAction {
        return UIAction(
            title: "Добавить в избранное",
            image: .init(systemName: "bookmark")
        ) { _ in
            
        }
    }
    
}

// MARK: - Constraints

private extension PurchaseCell {
    
    func addConstraints() {
        purchaseImage.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(10)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
        
        additionalButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }
        
        purchaseLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(purchaseImage.snp.trailing).offset(10)
        }
        
        purchaseType.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(purchaseLabel.snp.trailing).offset(5)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(purchaseLabel.snp.bottom).offset(5)
            make.leading.equalTo(purchaseImage.snp.trailing).offset(10)
            make.width.equalToSuperview().multipliedBy(0.5)
        }

        quantityLabel.snp.makeConstraints { make in
            make.leading.equalTo(purchaseImage.snp.trailing).offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
    }
    
}
