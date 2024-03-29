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
    
    func configure(with template: Template) {
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
        templateView.backgroundColor = .backMINI
        templateView.roundCorners(radius: 10)
        addSubview(templateView)
        templateView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
    
    func createCircleView() {
        circleView.backgroundColor = .backMINI
        templateView.addSubview(circleView)
        circleView.roundCorners(radius: 20)
        circleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(17)
            make.width.height.equalTo(40)
        }
    }
    
    func createImageView() {
        imageView.image = UIImage(.gear)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .front2MINI
        circleView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().inset(7)
        }
    }
    
    func createTextLabel() {
        textLabel.numberOfLines = 1
        textLabel.textAlignment = .center
        templateView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(10)
        }
    }
    
}
