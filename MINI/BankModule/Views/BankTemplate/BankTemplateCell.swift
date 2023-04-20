//
//  BankTemplateCell.swift
//  MINI
//
//  Created by Yan Rybkin on 20.04.2023.
//

import UIKit


final class BankTemplateCell: UICollectionViewCell {
    
    static let cellId = "BankTemplateCell"
    
    func configure() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let templateView = UIView()
    private let circleView = UIView()
    private let imageView = UIImageView(image: UIImage(systemName: "gear"))
    private let textLabel = UILabel(text: "Utility Payments", font: .systemFont(ofSize: 15), color: .black)
}

private extension BankTemplateCell {
    func initialize() {
        createTemplateView()
        createCircleView()
        createImageView()
        createTextLabel()
    }
    func createTemplateView() {
        templateView.backgroundColor = .white
        templateView.radiusAndShadow(radius: 10, shadowSize: 7)
        addSubview(templateView)
        templateView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(20)
        }
    }
    func createCircleView() {
        circleView.backgroundColor = .systemGray2
        templateView.addSubview(circleView)
        circleView.roundCorners(radius: 20)
        circleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(17)
            make.width.height.equalTo(40)
        }
    }
    func createImageView() {
        imageView.tintColor = .black
        circleView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().inset(7)
        }
    }
    func createTextLabel() {
        templateView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
}
