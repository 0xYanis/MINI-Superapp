//
//  AviaPlaceCell.swift
//  MINI
//
//  Created by Yan Rybkin on 11.09.2023.
//

import UIKit

final class AviaPlaceCell: UICollectionViewCell, AviaCellProtocol {
    
    private let titleLabel       = UILabel()
    private let imageView        = UIImageView()
    private let locationLabel    = UILabel()
    private let priceLabel       = UILabel()
    
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
        self.titleLabel.text = data.title
        self.imageView.image = UIImage()
        self.locationLabel.text = data.location
        self.priceLabel.text = "\(data.price ?? 0.0)"
    }
    
    private func initialize() {
        backgroundColor = .systemOrange
        //imageView.backgroundColor = .systemOrange
        insertSubview(imageView, at: 0)
        
        addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 16)
        
        addSubview(locationLabel)
        locationLabel.textColor = .gray
        locationLabel.font = .preferredFont(forTextStyle: .body)
        
        addSubview(priceLabel)
        priceLabel.font = .boldSystemFont(ofSize: 10)
        priceLabel.textColor = .white
        roundCorners(radius: 12)
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(20)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview().inset(20)
        }
    }
    
}
