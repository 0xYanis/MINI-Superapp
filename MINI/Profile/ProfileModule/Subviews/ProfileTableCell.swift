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
    
    private lazy var iconContainer: UIView = {
        let view = UIView()
        view.roundCorners(radius: 8)
        return view
    }()
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    private lazy var switcher = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.height - 12
        let imageSize: CGFloat = size/1.5
        
        iconContainer.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(15)
            make.width.equalTo(size)
            make.height.equalTo(size)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.center.equalTo(iconContainer)
            make.width.equalTo(imageSize)
            make.height.equalTo(imageSize)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconContainer.snp.right).offset(15)
        }
        
        switcher.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(15)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
    }
    
    func configure(with data: ProfileOption) {
        iconContainer.backgroundColor = UIColor(hex: data.iconBackground)
        iconImageView.image = UIImage(systemName: data.icon ?? "")
        label.text = data.title
        if data.isToggling {
            switcher.isHidden = false
            accessoryType = .none
            selectionStyle = .none
        }
    }
}

private extension ProfileTableCell {
    func initialize() {
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        contentView.addSubview(switcher)
        iconContainer.addSubview(iconImageView)
        
        switcher.isHidden = true
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
}
