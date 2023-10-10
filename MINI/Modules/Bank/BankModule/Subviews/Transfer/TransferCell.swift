//
//  TransferCell.swift
//  MINI
//
//  Created by Yanis on 10.10.2023.
//

import UIKit
import SDWebImage

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
    
    public func configure(with data: Transfer) {
        if let imageStr = data.image {
            imageView.sd_setImage(with: URL(string: imageStr))
        } else {
            imageView.image = .init(systemName: "person.fill")
        }
        nameLabel.text = data.name
        textLabel.text = data.text
    }
    
    private func initialize() {
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .init(white: 0.6, alpha: 0.25)
        
        textLabel.font = .systemFont(ofSize: 10)
        nameLabel.textAlignment = .center
        
        textLabel.font = .systemFont(ofSize: 8)
        textLabel.textColor = .secondaryLabel
        textLabel.textAlignment = .center
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(textLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(42)
            make.height.equalTo(42)
        }
        imageView.roundCorners(radius: 20)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset(10)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(10)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}
