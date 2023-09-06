//
//  PurchaseCell.swift
//  MINI
//
//  Created by Yan Rybkin on 06.09.2023.
//

import UIKit
import SnapKit

final class PurchaseCell: UITableViewCell {
    
    private let container = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension PurchaseCell {
    
    func initialize() {
        selectionStyle = .none
        backgroundColor = .clear
        container.backgroundColor = .systemBackground
        addSubview(container)
        container.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(8)
        }
        container.roundCorners(radius: 8)
    }
    
}
