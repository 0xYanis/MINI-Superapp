//
//  TransferCell.swift
//  MINI
//
//  Created by Yanis on 10.10.2023.
//

import UIKit

final class TransferCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func initialize() {
        
    }
    
}
