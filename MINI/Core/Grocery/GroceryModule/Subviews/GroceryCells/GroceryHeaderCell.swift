//
//  GroceryHeaderCell.swift
//  MINI
//
//  Created by Yan Rybkin on 18.05.2023.
//

import UIKit
import SnapKit
import SkeletonView

final class GroceryHeaderCell: UICollectionReusableView {
    
    static let cellId = "GroceryHeaderCell"
    
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

private extension GroceryHeaderCell {
    func initialize() {
        textLabel.isSkeletonable = true
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
