//
//  BankTemplateLabelCell.swift
//  MINI
//
//  Created by Yan Rybkin on 20.04.2023.
//

import UIKit

final class BankTemplateLabelCell: UITableViewCell, BankTableCellConf {
    
    static let cellId = "BankTemplateLabelCell"
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        
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
        seeAllButt.addPulseAnimation()
        seeAllButt.addTarget(
            self,
            action: #selector(didTapSeeAllButt),
            for: .touchUpInside
        )
        seeAllButt.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
        
        
    }
    
    @objc func didTapSeeAllButt() {
        presenter?.userWantToDetails(of: .allTransactions, with: 0)
    }
    
}
