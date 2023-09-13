//
//  ProfileHeader.swift
//  MINI
//
//  Created by Yan Rybkin on 14.08.2023.
//

import UIKit

final class ProfileHeader: UIView {
    
    private lazy var imageView = UIImageView()
    private lazy var nameLabel = UILabel()
    private lazy var addressLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createConstraints()
        imageView.layer.cornerRadius = 37
        imageView.clipsToBounds = true
    }
    
    public func setAvatar(_ image: UIImage) {
        imageView.image = image
    }
    
    public func configure(name: String, address: String) {
        nameLabel.text = name
        addressLabel.text = address
    }
    
}

private extension ProfileHeader {
    
    func initialize() {
        backgroundColor = .back2MINI
        if let url = UserDefaults.standard.url(forKey: "avatarUrl") {
            imageView.sd_setImage(with: url)
        } else {
            imageView.image = UIImage(named: "AppIcon")
        }
        imageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .boldSystemFont(ofSize: 24)
        nameLabel.textAlignment = .center
        nameLabel.text = "User"
        
        addressLabel.font = .systemFont(ofSize: 14)
        addressLabel.textColor = .gray
        addressLabel.textAlignment = .center
        addressLabel.text = "San-Antonio, TX"
    }
    
    func createConstraints() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(75)
            make.height.equalTo(75)
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(15)
        }
        
        addSubview(addressLabel)
        addressLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
        }
    }
    
}
