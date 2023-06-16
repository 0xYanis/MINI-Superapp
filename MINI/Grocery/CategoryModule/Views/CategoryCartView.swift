//
//  CategoryCartView.swift
//  MINI
//
//  Created by Yan Rybkin on 12.06.2023.
//

import UIKit
import SnapKit

final class CategoryCartView: UIView {

    private lazy var labelView = UIView()
    private lazy var cartLabel = UILabel()
    
    private lazy var imageView = UIView()
    private lazy var cartImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with price: String) {
        cartLabel.text = "Всего: $\(price)"
    }
}

private extension CategoryCartView {
    func initialize() {
        backgroundColor = .systemGray3
        createCartLabel()
        createCartImage()
    }
    
    func createCartLabel() {
        labelView.backgroundColor = .systemGray5
        labelView.roundCorners(radius: 20)
        addSubview(labelView)
        labelView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(7)
            make.width.equalToSuperview().multipliedBy(0.65)
        }
        
        cartLabel.font = .boldSystemFont(ofSize: 20)
        cartLabel.textColor = .systemOrange
        
        labelView.addSubview(cartLabel)
        cartLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func createCartImage() {
        imageView.backgroundColor = .systemGray5
        imageView.roundCorners(radius: 20)
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview().inset(7)
            make.left.equalTo(labelView.snp.right).offset(7)
        }
        
        cartImage.image = UIImage(systemName: "cart.fill")
        cartImage.layer.shadowColor = UIColor.black.cgColor
        cartImage.layer.shadowOpacity = 0.5
        cartImage.layer.shadowOffset = CGSize(width: 0, height: 0)
        cartImage.layer.shadowRadius = 5.0
        cartImage.clipsToBounds = false
        
        cartImage.contentMode = .scaleAspectFit
        imageView.addSubview(cartImage)
        cartImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(0.6)
        }
    }
}
