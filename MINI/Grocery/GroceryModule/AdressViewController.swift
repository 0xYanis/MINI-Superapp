//
//  AdressViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 16.05.2023.
//

import UIKit
import SnapKit

final class AdressViewController: UIViewController {
    
    private lazy var textTilte = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

private extension AdressViewController {
    func initialize() {
        view.backgroundColor = .black
        createTitle(text: "Select Your actual adress")
    }
    
    func createTitle(text: String) {
        textTilte.text = text
        textTilte.tintColor = .white
        textTilte.font = .boldSystemFont(ofSize: 25)
        view.addSubview(textTilte)
        textTilte.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
        }
    }
    
}
