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
        createNavigation()
        view.backgroundColor = .back2MINI
    }
    
    func createNavigation() {
        navigationItem.title = "tickets_navbar".localized
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
