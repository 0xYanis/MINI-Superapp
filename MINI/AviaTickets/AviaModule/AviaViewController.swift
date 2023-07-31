//
//  AviaViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 03.05.2023.
//

import UIKit
import SnapKit

protocol AviaViewProtocol: AnyObject {
    func updateView()
    func loadingDataGetFailed(with error: String)
}

final class AviaViewController: UIViewController {
    
    //MARK: - Public properties
    
    var presenter: AviaPresenterProtocol?
    
    //MARK: - Private properties
    
    private lazy var refreshControl   = UIRefreshControl()
    private lazy var searchController = UISearchController()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.showTabBar()
    }
    
}

//MARK: - AviaViewProtocol

extension AviaViewController: AviaViewProtocol {
    
    func updateView() {
        
    }
    
    func loadingDataGetFailed(with error: String) {
        
    }
    
}

//MARK: - Private methods

private extension AviaViewController {
    
    func initialize() {
        view.backgroundColor = .back2MINI
        createNavigation()
        createSearchController()
    }
    
    func createNavigation() {
        navigationItem.searchController = searchController
        navigationItem.title = "tickets_navbar".localized
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func createSearchController() {
        
    }
    
    func createRefreshControl(scrollView: UIScrollView) {
        refreshControl.addTarget(
            self,
            action: #selector(refreshAction),
            for: .valueChanged
        )
        scrollView.refreshControl = refreshControl
    }
    
}

// MARK: - Action methods

private extension AviaViewController {
    
    @objc func refreshAction() {
        refreshControl.endRefreshing()
    }
    
}
