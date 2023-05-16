//
//  BankTemplateLabelCell.swift
//  MINI
//
//  Created by Yan Rybkin on 20.04.2023.
//

import UIKit

final class BankTemplateLabelCell: UITableViewCell {
    
    private lazy var titleLabel = UILabel(
        text: "Templates",
        font: .boldSystemFont(ofSize: 24),
        color: UIColor(named: "textColor")
    )
    let seeAllButt: UIButton = {
        let button = UIButton()
        button.addPulseAnimation()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        return button
    }()
    
    static let cellId = "BankTemplateLabelCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BankTemplateLabelCell {
    func initialize() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16)
        }
        contentView.addSubview(seeAllButt)
        seeAllButt.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
    }
}
