//
//  AviaCityCell.swift
//  MINI
//
//  Created by Yan Rybkin on 11.09.2023.
//

import UIKit

final class AviaCityCell: UICollectionViewCell, AviaCellProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    func configure(with data: AviaItem) {
        
    }
    
    private func initialize() {
        backgroundColor = .systemOrange
        roundCorners(radius: 0)
    }
    
    private func setConstraints() {
        
    }
    
}
