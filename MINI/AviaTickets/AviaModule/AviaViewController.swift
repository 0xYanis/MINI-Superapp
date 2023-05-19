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
    private let searchView = UIView()
    private let tableView = UITableView()
    
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
        view.backgroundColor = UIColor(named: "backColor")
        createNavigation()
        createSearchView()
        createtableView()
        tableViewRegistrate()
    }
    
    func createNavigation() {
        navigationItem.title = "Tickets"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func createSearchView() {
        searchView.roundCorners(radius: 30)
        searchView.backgroundColor = .black
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(view.frame.height / 3)
        }
    }
    
    func createtableView() {
        tableView.separatorInset = .zero
        tableView.separatorColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.roundCorners(radius: 30)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(searchView.snp.bottom).offset(15)
        }
    }
    
    func tableViewRegistrate() {
        tableView.register(
            AviaResultsCell.self,
            forCellReuseIdentifier: AviaResultsCell.cellId
        )
    }
}

extension AviaViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        15
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AviaResultsCell.cellId,
            for: indexPath
        ) as? AviaResultsCell else { return UITableViewCell() }
        
        return cell
    }
    
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        
    }
}

extension AviaViewController: UITableViewDelegate {
    //TODO: - updateConstraints при скроллинге
}
