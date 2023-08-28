//
//  CategoryCell.swift
//  MINI
//
//  Created by Yan Rybkin on 12.06.2023.
//

import UIKit
import SnapKit

final class CategoryCell: UICollectionViewCell {
    
    //MARK: Public properties
    static let cellId = "CategoryCell"
    
    //MARK: Private properties
    var isAddedToCart: Bool       = false
    private lazy var view         = UIView()
    private lazy var textLabel    = UILabel()
    private lazy var imageView    = UIImageView()
    
    lazy var priceButton = UIButton(
        label: "$59.9",
        color: .gray,
        cornerRadius: 15
    )
    
    private lazy var discountView = UIView()
    private lazy var percentView  = UIImageView()
    
    //MARK: Public methods
    func configure(with data: GroceryEntity) {
        textLabel.text = data.productName
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func updateButton() {
        isAddedToCart ? priceButton.setTitle(
            "Added",
            for: .normal
        ) : priceButton.setTitle(
            "$59.9",
            for: .normal
        )
        
        priceButton.backgroundColor = isAddedToCart ? .systemOrange : .gray
    }
    
}

//MARK: - Private methods
private extension CategoryCell {
    func initialize() {
        createView()
        createTextLabel()
        createImageView()
        createPriceButton()
        
        createDiscountView()
    }
    
    func createView() {
        view.radiusAndShadow(radius: 30)
        view.backgroundColor = .backMINI
        addSubview(view)
        view.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.66)
        }
    }
    
    func createTextLabel() {
        textLabel.text = "Double Big mac with extra cheese"
        textLabel.textColor = .tintMINI
        textLabel.font = .boldSystemFont(ofSize: 12)
        textLabel.numberOfLines = 2
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom).offset(7)
            make.right.left.equalToSuperview()
        }
    }
    
    func createPriceButton() {
        priceButton.titleLabel?.font = .systemFont(ofSize: 15)
        priceButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        addSubview(priceButton)
        priceButton.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(7)
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
        }
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 1.33, y: 1.33)
        }) {_ in
            self.buttonReleased(sender)
        }
    }

    func buttonReleased(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform.identity
        }
    }
    
    func createImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "burger")
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalToSuperview().multipliedBy(0.7)
            make.center.equalToSuperview()
        }
    }
    
    func createDiscountView() {
        discountView.roundCorners(radius: 10)
        discountView.backgroundColor = .tintMINI
        view.insertSubview(discountView, at: 1)
        discountView.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().inset(10)
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
