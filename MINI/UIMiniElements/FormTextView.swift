//
//  FormTextView.swift
//  MINI
//
//  Created by Yan Rybkin on 16.08.2023.
//

import UIKit
import SnapKit

final class FormTextView: UIView {
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.setCustomAppearance()
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().multipliedBy(0.5)
        }
        addSubview(descriptionLabel)
        textLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func addText(text: String, description: String) {
        textLabel.text = text
        descriptionLabel.text = description
    }
    
}

