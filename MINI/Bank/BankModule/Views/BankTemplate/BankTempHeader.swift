//
//  BankTemplateHeaderCell.swift
//  MINI
//
//  Created by Yan Rybkin on 20.04.2023.
//

import UIKit

final class BankTempHeader: UICollectionReusableView {
    
    static let cellId = "BankTemplateHeaderCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tempLabel = UILabel(text: "Templates", font: .boldSystemFont(ofSize: 20), color: .black)
}

private extension BankTempHeader {
    func initialize() {
        backgroundColor = .orange
    }
    func createLabel() {
        addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
        }
    }
}
