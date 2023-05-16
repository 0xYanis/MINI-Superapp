//
//  GroceryViewCell.swift
//  MINI
//
//  Created by Yan Rybkin on 17.05.2023.
//

import UIKit

final class GroceryViewCell: UICollectionViewCell {
    
    static let cellId = "GroceryViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension GroceryViewCell {
    func initialize() {
        
    }
}
