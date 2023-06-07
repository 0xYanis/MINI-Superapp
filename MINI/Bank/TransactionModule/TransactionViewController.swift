//
//  TransactionViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import UIKit
import SnapKit

protocol TransactionViewProtocol: AnyObject {
    func updateView(with data: BankTransactionEntity)
}

final class TransactionViewController: UIViewController {
    
    var presenter: TransactionPresenterProtocol?
    
    private lazy var tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
}

extension TransactionViewController: TransactionViewProtocol {
    func updateView(with data: BankTransactionEntity) {
        
    }
}

private extension TransactionViewController {
    func initialize() {
        view.backgroundColor = UIColor(named: "backColor")
        createNavigation()
        createTableView(tableView: tableView)
    }
    
    func createNavigation() {
        navigationItem.title = "Transaction"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func createTableView(tableView: UITableView) {
        tableView.backgroundColor = .clear
        tableView.separatorColor = .black
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDataSource
extension TransactionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row) cell"
        cell.backgroundColor = .clear
        cell.detailTextLabel?.text = "\(indexPath.row)"
        cell.imageView?.image = UIImage(systemName: "note.text")
        return cell
    }
}
