//
//  BankViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit
import SnapKit

protocol BankViewProtocol: AnyObject {
    func updateCards()
    func updateHistory()
}

final class BankViewController: UIViewController {
    
    var presenter: BankPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private let bankTableView = BankTableView()
}

extension BankViewController: BankViewProtocol {
    func updateCards() {
        
    }
    
    func updateHistory() {
        
    }
}

private extension BankViewController {
    func initialize() {
        view.backgroundColor = UIColor(named: "backColor")
        createNavigation()
        createBankTableView()
        createSheet()
    }
    func createNavigation() {
        navigationItem.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func createBankTableView() {
        bankTableView.backgroundColor = .systemCyan
        view.addSubview(bankTableView)
        bankTableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
    }
    func createSheet() {
        
    }
}
