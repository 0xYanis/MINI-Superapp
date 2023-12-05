//
//  BankEmptyCardCell.swift
//  MINI
//
//  Created by Yanis on 04.10.2023.
//

import UIKit

final class BankEmptyCardCell: UICollectionViewCell {
    
    private let cardView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func initialize() {
        cardView.roundCorners(radius: 10)
        cardView.backgroundColor = .systemGroupedBackground
        
        addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        let image = UIImageView(image: .init(.plus))
        image.contentMode = .scaleAspectFit
        image.tintColor = .label
        
        cardView.addSubview(image)
        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(0.22)
        }
    }
    
}
