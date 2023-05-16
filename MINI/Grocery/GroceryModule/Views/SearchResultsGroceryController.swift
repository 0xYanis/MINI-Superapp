//
//  SearchResultsGroceryController.swift
//  MINI
//
//  Created by Yan Rybkin on 16.05.2023.
//

import UIKit

final class SearchResultsGroceryController: UIViewController {
    
    private lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension SearchResultsGroceryController {
    func initialize() {
        tableView.backgroundColor = .red
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
