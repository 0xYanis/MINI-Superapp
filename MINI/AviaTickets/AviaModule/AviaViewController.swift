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
    
    //MARK: Public properties
    var presenter: AviaPresenterProtocol?
    
    
    //MARK: Private properties
    private lazy var refreshControl   = UIRefreshControl()
    private lazy var segmentedControl = UISegmentedControl(items: ["first","second"])
    private lazy var searchController = UISearchController()
    private lazy var scrollView       = AviaScrollView()
    
    //MARK: Lifecycle
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
    
}

//MARK: - Private methods
private extension AviaViewController {
    func initialize() {
        view.backgroundColor = UIColor(named: "backColor")
        createNavigation()
        createSearchController()
        createScrollView()
        createRefreshControl(scrollView: scrollView)
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
    
    func createScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}

private extension AviaViewController {
    @objc func refreshAction() {
        refreshControl.endRefreshing()
    }
    
    
}
