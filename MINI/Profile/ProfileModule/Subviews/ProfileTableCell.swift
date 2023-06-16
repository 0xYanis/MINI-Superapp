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
        
        iconContainer.frame = .init(
            x: 15,
            y: 6,
            width: size,
            height: size
        )
        
        let imageSize: CGFloat = size/1.5
        
        iconImageView.frame = .init(
            x: (size - imageSize)/2,
            y: (size - imageSize)/2,
            width: imageSize,
            height: imageSize
        )
        
        label.frame = .init(
            x: 25 + iconContainer.frame.width,
            y: 0,
            width: contentView.frame.width - 15 - iconContainer.frame.width,
            height: contentView.frame.height
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
    }
    
    func configure(with data: ProfileOption) {
        iconImageView.image = UIImage(systemName: data.icon ?? "")
        label.text = data.title
        iconContainer.backgroundColor = UIColor(named: data.iconBackground)
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
