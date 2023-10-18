//
//  TransferHeader.swift
//  MINI
//
//  Created by Yanis on 10.10.2023.
//

import UIKit

final class TransferHeader: UICollectionReusableView {
    
    weak var presenter: BankPresenterProtocol?
    
    private let titleLabel = UILabel(
        text: "Перевод",
        font: .boldSystemFont(ofSize: 20),
        color: UIColor(named: "textColor")
    )
    
    private let seeAllButt: UIButton = {
        let button = UIButton()
        button.addPulseAnimation()
        //button.setTitle("see_all_button".localized, for: .normal)
        button.setImage(UIImage(.chevronRigthCircle), for: .normal)
        button.tintColor = .label
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

private extension TransferHeader {
    
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
        
    }
    
}

