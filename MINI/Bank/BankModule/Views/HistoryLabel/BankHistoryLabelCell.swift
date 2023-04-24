//
//  BankHistoryLabelCell.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit

final class BankHistoryLabelCell: UITableViewCell {
    weak var delegate: BankViewCellDelegate?
    
    static let cellId = "BankHistoryLabelCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let seeHistoryButton = UIButton()
}

private extension BankHistoryLabelCell {
    func initialize() {
        backgroundColor = .clear
        seeHistoryButton.setTitle("See all history..", for: .normal)
        seeHistoryButton.setTitleColor(.systemOrange, for: .normal)
        seeHistoryButton.addTarget(self, action: #selector(tapHistoryAction), for: .touchUpInside)
        contentView.addSubview(seeHistoryButton)
        seeHistoryButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func tapHistoryAction() {
        delegate?.handleTapOnSeeHistoryCell()
    }
}
