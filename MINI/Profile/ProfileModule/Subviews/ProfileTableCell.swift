//
//  ProfileTableCell.swift
//  MINI
//
//  Created by Yan Rybkin on 16.06.2023.
//

import UIKit
import SnapKit

final class ProfileTableCell: UITableViewCell {
    
    static let cellId = "ProfileTableCell"
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.roundCorners(radius: 8)
        return view
    }()
    private let iconImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        return view
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    private var switcher = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = 30
        let imageSize: CGFloat = 20
        
        iconContainer.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(15)
            make.width.equalTo(size)
            make.height.equalTo(size)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(imageSize)
            make.height.equalTo(imageSize)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconContainer.snp.right).offset(15)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconContainer.backgroundColor = nil
        iconImageView.image = nil
        label.text = nil
        accessoryView = nil
    }
    
    func configure(with data: ProfileOption,_ row: Int) {
        iconContainer.backgroundColor = UIColor(hex: data.iconBackground)
        iconImageView.image = UIImage(systemName: data.icon ?? "")
        label.text = data.title
        switcher.tag = row
        accessoryView = data.switcher ? switcher : nil
    }
    
}

private extension ProfileTableCell {
    
    func initialize() {
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
}
