//
//  BankTemplateCell.swift
//  MINI
//
//  Created by Yan Rybkin on 20.04.2023.
//

import UIKit
import SkeletonView

final class BankTemplateCell: UICollectionViewCell {
    
    private lazy var templateView = UIView()
    private lazy var circleView = UIView()
    private lazy var imageView = UIImageView()
    private lazy var textLabel = UILabel(
        text: "Utility Payments",
        font: .systemFont(ofSize: 15),
        color: UIColor(named: "textColor")
    )
    
    static let cellId = "BankTemplateCell"
    
    func configure(with template: BankTemplateEntity) {
        imageView.image = UIImage(systemName: template.image)
        textLabel.text = template.label
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BankTemplateCell {
    func initialize() {
        isSkeletonable = true
        skeletonCornerRadius = 10
        backgroundColor = .clear
        createTemplateView()
        createCircleView()
        createImageView()
        createTextLabel()
    }
    func createTemplateView() {
        templateView.backgroundColor = .systemGray6//UIColor(named: "whiteColor")
        templateView.radiusAndShadow(radius: 10, shadowSize: 7)
        addSubview(templateView)
        templateView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
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
        imageView.image = UIImage(systemName: "gear")
        imageView.contentMode = .scaleAspectFit
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
