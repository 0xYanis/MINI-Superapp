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
}

private extension CategoryCartView {
    func initialize() {
        backgroundColor = .gray
        createCartLabel()
        createCartImage()
    }
    
    func createCartLabel() {
        labelView.backgroundColor = .lightGray
        addSubview(labelView)
        labelView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(7)
            make.width.equalToSuperview().multipliedBy(0.65)
        }
        
        cartLabel.font = .boldSystemFont(ofSize: 20)
        cartLabel.text = "Всего: $289.49"
        cartLabel.textColor = .white
        
        labelView.addSubview(cartLabel)
        cartLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func createCartImage() {
        imageView.backgroundColor = .lightGray
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview().inset(7)
            make.left.equalTo(labelView.snp.right).offset(7)
        }
        
        cartImage.image = UIImage(systemName: "cart.fill")
        
        imageView.addSubview(cartImage)
        cartImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(0.7)
        }
    }
}
