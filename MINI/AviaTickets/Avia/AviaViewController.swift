//
//  AviaViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 03.05.2023.
//

import UIKit
import SnapKit

protocol AviaViewProtocol: AnyObject {
    
}

final class AviaViewController: UIViewController {
    
    //MARK: - Private properties
    private let searchView = AviaSearchView()
    private let resultsTable = UITableView()
    
    //MARK: - Public properties
    var presenter: AviaPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

//MARK: - AviaViewProtocol
extension AviaViewController: AviaViewProtocol {
    
}

//MARK: - Private methods
private extension AviaViewController {
    func initialize() {
        view.backgroundColor = .white
        createNavBarItems()
        createSearchView()
        createResultsTable()
        resultsTableRegistrate()
    }
    
    func createNavBarItems() {
        navigationItem.title = "Tickets"
    }
    
    func createSearchView() {
        searchView.roundBottomCorners(radius: 30)
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(view.frame.height / 2.5)
        }
    }
    
    func createResultsTable() {
        resultsTable.backgroundColor = .cyan
        resultsTable.roundTopCorners(radius: 30)
        resultsTable.dataSource = self
        resultsTable.delegate = self
        view.addSubview(resultsTable)
        resultsTable.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(searchView.snp.bottom).offset(10)
        }
    }
    
    func resultsTableRegistrate() {
        resultsTable.register(
            AviaResultsCell.self, forCellReuseIdentifier: AviaResultsCell.cellId
        )
    }
}

//MARK: - UITableViewDataSource
extension AviaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AviaResultsCell.cellId, for: indexPath
            ) as? AviaResultsCell else { return defaultCell }
            return cell
        default:
            return defaultCell
        }
    }
    
}

//MARK: - UITableViewDelegate
extension AviaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
