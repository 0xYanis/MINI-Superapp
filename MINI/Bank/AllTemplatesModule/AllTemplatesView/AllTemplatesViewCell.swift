//
//  AllTemplatesViewCell.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import UIKit

final class AllTemplatesViewCell: UICollectionViewCell {
    
    static let cellId = "AllTemplatesViewCell"
    
    func configure(name: String, image: String) {
        textLabel.text = name
        imageView.image = UIImage(systemName: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private properties
    private let templateView = UIView()
    private let circleView   = UIView()
    private let imageView    = UIImageView(image: UIImage(systemName: "gear"))
    private let textLabel    = UILabel(text: "Utility Payments",
                                       font: .systemFont(ofSize: 15),
                                       color: UIColor(named: "textColor"))
}

private extension AllTemplatesViewCell {
    func initialize() {
        backgroundColor = .clear
        createTemplateView()
        createCircleView()
        createImageView()
        createTextLabel()
    }
    
    func createTemplateView() {
        templateView.backgroundColor = .systemGray6
        templateView.roundCorners(radius: 10)
        addSubview(templateView)
        templateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func createCircleView() {
        circleView.backgroundColor = .systemGray2
        templateView.addSubview(circleView)
        circleView.roundCorners(radius: 20)
        circleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
            make.width.height.equalTo(60)
        }
    }
    
    func createImageView() {
        imageView.tintColor = .black
        circleView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().inset(14)
        }
    }
    
    func createTextLabel() {
        templateView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
    }
}
