//
//  BankTemplateLabelCell.swift
//  MINI
//
//  Created by Yan Rybkin on 20.04.2023.
//

import UIKit

final class BankTemplateLabelCell: UICollectionReusableView {
    
    weak var presenter: BankPresenterProtocol?
    
    private lazy var titleLabel = UILabel(
        text: "templates_label".localized,
        font: .boldSystemFont(ofSize: 22),
        color: UIColor(named: "textColor")
    )
    
    private lazy var seeAllButt: UIButton = {
        let button = UIButton()
        button.addPulseAnimation()
        button.setTitle("see_all_button".localized, for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

private extension BankTemplateLabelCell {
    
    func initialize() {
        backgroundColor = .clear
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        addSubview(seeAllButt)
        seeAllButt.addPulseAnimation()
        seeAllButt.addTarget(
            self,
            action: #selector(didTapSeeAllButt),
            for: .touchUpInside
        )
        seeAllButt.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        
    }
    
    @objc func didTapSeeAllButt() {
        presenter?.userWantToDetails(of: .allTransactions, with: 0)
    }
    
}
