//
//  AviaCountryCell.swift
//  MINI
//
//  Created by Yan Rybkin on 11.09.2023.
//

import UIKit

final class AviaCountryCell: UICollectionViewCell, AviaCellProtocol {
    
    private let titleLabel       = UILabel()
    private let imageView        = UIImageView()
    private let locationLabel    = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with data: AviaItem) {
        self.titleLabel.text = data.title
        self.imageView.image = UIImage()
        self.locationLabel.text = data.location
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
        
        roundCorners(radius: 12)
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(20)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(20)
        }
    }
    
}

