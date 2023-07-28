//
//  AllTemplatesViewCell.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import UIKit

final class AllTemplatesViewCell: UICollectionViewCell, CellConfProtocol {
    
    static let cellId = "AllTemplatesViewCell"
    
    //MARK: - Private properties
    private let templateView = UIView()
    private let circleView   = UIView()
    private let imageView    = UIImageView(image: UIImage(systemName: "gear"))
    private let textLabel    = UILabel(
        text: "Utility Payments",
        font: .systemFont(ofSize: 15),
        color: .black
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, image: String) {
        textLabel.text = name
        imageView.image = UIImage(systemName: image)
    }
}

private extension AllTemplatesViewCell {
    func initialize() {
        backgroundColor = .clear
        layer.cornerRadius = 10
        layer.masksToBounds = true
        createTemplateView()
        createCircleView()
        createImageView()
        createTextLabel()
    }
    
    func createTemplateView() {
        templateView.backgroundColor = .frontMINI
        addSubview(templateView)
        templateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func createCircleView() {
        circleView.backgroundColor = .backMINI
        templateView.addSubview(circleView)
        circleView.roundCorners(radius: 30)
        circleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(40)
            make.width.height.equalTo(60)
        }
    }
    
    func createImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .front2MINI
        circleView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().inset(14)
        }
    }
    
    func createTextLabel() {
        templateView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
    }
}
