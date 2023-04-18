//
//  BankHistoryTableViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 18.04.2023.
//

import UIKit
import SnapKit

final class BankHistoryTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialize()
    }
    
}

//MARK: - Private methods
private extension BankHistoryTableViewController {
    func intialize() {
        tableView.separatorStyle = .none
        tableView.register(BankHistoryFirstCell.self, forCellReuseIdentifier: BankHistoryFirstCell.cellId)
        tableView.register(BankTransactionCell.self, forCellReuseIdentifier: BankTransactionCell.cellId)
    }
}

//MARK: - Delegate & DataSource
extension BankHistoryTableViewController {
    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BankHistoryFirstCell.cellId,
                for: indexPath) as? BankHistoryFirstCell else { return defaultCell }
            cell.layoutIfNeeded()
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BankTransactionCell.cellId,
                for: indexPath) as? BankTransactionCell else { return defaultCell }
            cell.layoutIfNeeded()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 55
        default:
            return 100
        }
    }
}
