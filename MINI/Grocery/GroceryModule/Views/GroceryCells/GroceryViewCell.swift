//
//  GroceryViewCell.swift
//  MINI
//
//  Created by Yan Rybkin on 17.05.2023.
//

import UIKit
import SnapKit

final class GroceryViewCell: UICollectionViewCell {
    
    static let cellId = "GroceryViewCell"
    
    private lazy var textLabel    = UILabel()
    private lazy var imageView    = UIImageView()
    private lazy var discountView = UIView()
    private lazy var percentView  = UIImageView()
    
    func configure() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension GroceryViewCell {
    func initialize() {
        backgroundColor = .black
        createTextLabel()
        createImageView()
        
        createDiscountView()
    }
    
    func createTextLabel() {
        textLabel.text = "Double Big mac with extra cheese"
        textLabel.textColor = .white
        textLabel.font = .boldSystemFont(ofSize: 12)
        textLabel.numberOfLines = 3
        insertSubview(textLabel, at: 1)
        textLabel.snp.makeConstraints { make in
            make.right.left.top.equalToSuperview().inset(7)
        }
    }
    
    func createImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "burger")
        insertSubview(imageView, at: 0)
        imageView.snp.makeConstraints { make in
            make.size.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func createDiscountView() {
        discountView.roundCorners(radius: 10)
        discountView.backgroundColor = .systemOrange
        insertSubview(discountView, at: 1)
        discountView.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().inset(7)
            make.height.width.equalTo(20)
        }
        
        createPercentView()
    }
    
    func createPercentView() {
        percentView.image = UIImage(systemName: "percent")
        percentView.tintColor = .black
        discountView.addSubview(percentView)
        percentView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(2)
        }
    }
}
