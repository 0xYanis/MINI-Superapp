//
//  CategoryHeader.swift
//  MINI
//
//  Created by Yan Rybkin on 12.06.2023.
//

import UIKit

final class CategoryHeader: UICollectionReusableView {
    
    static let cellId = "CategoryHeader"
    
    private lazy var textLabel = UILabel()
    
    func configure(with text: String) {
        textLabel.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CategoryHeader {
    func initialize() {
        textLabel.text = "Category"
        textLabel.numberOfLines = 1
        textLabel.textColor = .front2MINI
        textLabel.font = .boldSystemFont(ofSize: 18)
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }
    }
    
}
