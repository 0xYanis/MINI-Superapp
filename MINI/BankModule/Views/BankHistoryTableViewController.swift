//
//  BankHistoryTableViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 18.04.2023.
//

import UIKit
import SnapKit

class BankHistoryTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialize()
    }
}

private extension BankHistoryTableViewController {
    func intialize() {
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId1")
    }
    
}

extension BankHistoryTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = UITableViewCell()
            cell.backgroundColor = .red
            return cell
        } else {
            let cell = UITableViewCell()
            cell.backgroundColor = .red
            return cell
        }
    }
}
