//
//  AdressViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 16.05.2023.
//

import UIKit
import SnapKit

protocol AdressViewDelegate: AnyObject {
    func cancelButtonTapped()
}

final class AdressViewController: UIViewController {
    
    weak var delegate: AdressViewDelegate?
    
    private lazy var textTilte = UILabel()
    private lazy var cancelButton = UIButton(
        systemImage: "xmark.circle.fill",
        color: .systemOrange,
        size: 35
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

private extension AdressViewController {
    func initialize() {
        view.backgroundColor = .black
        createTitle(text: "New adress")
        createCancelButton()
    }
    
    func createTitle(text: String) {
        textTilte.text = text
        textTilte.tintColor = .white
        textTilte.font = .boldSystemFont(ofSize: 25)
        view.addSubview(textTilte)
        textTilte.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(20)
        }
    }
    
    func createCancelButton() {
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(20)
        }
        cancelButton.addTarget(
            self,
            action: #selector(cancelButtonAction),
            for: .touchUpInside
        )
    }
}

private extension AdressViewController {
    @objc func cancelButtonAction() {
        delegate?.cancelButtonTapped()
    }
}
