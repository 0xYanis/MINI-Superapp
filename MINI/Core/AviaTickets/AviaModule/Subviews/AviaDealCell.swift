//
//  AviaDealCell.swift
//  MINI
//
//  Created by Yan Rybkin on 11.09.2023.
//

import UIKit

final class AviaDealCell: UICollectionViewCell, AviaCellProtocol {
    
    private let titleLabel       = UILabel()
    private let descriptionLabel = UILabel()
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
        self.descriptionLabel.text = data.description
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
        addSubview(descriptionLabel)
        descriptionLabel.textColor = .gray
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
        
        descriptionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(35)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(20)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview().inset(20)
        }
    }
    
}
