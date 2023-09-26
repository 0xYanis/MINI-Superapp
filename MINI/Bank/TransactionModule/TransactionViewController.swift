//
//  TransactionViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import UIKit
import SnapKit
import SDWebImage

protocol TransactionViewProtocol: AnyObject {
    func updateView(with data: BankTransactionEntity)
}

final class TransactionViewController: UIViewController {
    
    var presenter: TransactionPresenterProtocol?
    
    private let tableView = TransactionTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
    
}

extension TransactionViewController: TransactionViewProtocol {
    
    func updateView(with data: BankTransactionEntity) {
        tableView.configure(with: data)
    }
    
}

private extension TransactionViewController {
    
    func initialize() {
        view.backgroundColor = .back2MINI
        createNavigation()
        createTableView()
    }
    
    func createNavigation() {
        navigationItem.title = "Transaction"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func createTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}
