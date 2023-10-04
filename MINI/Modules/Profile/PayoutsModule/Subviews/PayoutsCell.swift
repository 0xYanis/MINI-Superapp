//
//  PayoutsCell.swift
//  MINI
//
//  Created by Yan Rybkin on 21.08.2023.
//

import UIKit
import SDWebImage

final class PayoutsCell: UITableViewCell {
    
    static var cellId = "PayoutsCell"
    
    private lazy var image = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var descriptionLabel = UILabel()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier:  reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    public func configure(with data: PayoutsModel) {
        self.image.image = UIImage(named: "AppIcon")
        self.titleLabel.text = data.title
        self.descriptionLabel.text = data.description
    }
    
}

private extension PayoutsCell {
    
    func initialize() {
        createImage()
        createLabels()
    }
    
    func createImage() {
        image.contentMode = .scaleAspectFit
        
        addSubview(image)
        image.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }
    }
    
    func createLabels() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(image.snp.right)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalTo(image.snp.right)
        }
    }
    
}
