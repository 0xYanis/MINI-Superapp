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
    private lazy var searchController = UISearchController()
    
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
    }
    
    func createNavigation() {
        navigationItem.searchController = searchController
        navigationItem.title = "tickets_navbar".localized
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
