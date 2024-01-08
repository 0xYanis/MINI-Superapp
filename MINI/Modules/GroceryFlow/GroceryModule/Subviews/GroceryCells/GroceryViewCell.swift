//
//  GroceryViewCell.swift
//  MINI
//
//  Created by Yan Rybkin on 17.05.2023.
//

import UIKit
import SnapKit
import SDWebImage

final class GroceryViewCell: UICollectionViewCell {
    
    // MARK: Private properties
    
    private let textLabel    = UILabel()
    private let imageView    = UIImageView()
    private let discountView = UIView()
    private let percentView  = UIImageView()
    
    // MARK: Public methods
    
    func configure(with data: GroceryItem) {
        textLabel.text = data.productName
        imageView.sd_setImage(with: URL(string: data.image))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

//MARK: - Private methods
private extension GroceryViewCell {
    
    func initialize() {
        backgroundColor = .backMINI
        createTextLabel()
        createImageView()
        
        createDiscountView()
        radiusAndShadow(radius: 12, color: .black, opacity: 0.15, shadowSize: 8)
    }
    
    func createTextLabel() {
        textLabel.textColor = .tintMINI
        textLabel.font = .boldSystemFont(ofSize: 12)
        textLabel.numberOfLines = 3
        insertSubview(textLabel, at: 1)
        textLabel.snp.makeConstraints { make in
            make.right.left.top.equalToSuperview().inset(7)
        }
    }
    
    func createImageView() {
        imageView.contentMode = .scaleToFill
        insertSubview(imageView, at: 0)
        imageView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func createDiscountView() {
        discountView.roundCorners(radius: 10)
        discountView.backgroundColor = .tintMINI
        insertSubview(discountView, at: 1)
        discountView.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().inset(7)
            make.height.width.equalTo(20)
        }
        
        createPercentView()
    }
    
    func createPercentView() {
        percentView.image = UIImage(.percent)
        percentView.tintColor = .backMINI
        discountView.addSubview(percentView)
        percentView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(2)
        }
    }
}
