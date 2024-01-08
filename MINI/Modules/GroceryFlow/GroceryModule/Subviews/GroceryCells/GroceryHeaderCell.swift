//
//  GroceryHeaderCell.swift
//  MINI
//
//  Created by Yan Rybkin on 18.05.2023.
//

import UIKit
import SnapKit

final class GroceryHeaderCell: UICollectionReusableView {
    
    private let textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with text: String) {
        textLabel.text = text
    }
    
}

private extension GroceryHeaderCell {
    
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
