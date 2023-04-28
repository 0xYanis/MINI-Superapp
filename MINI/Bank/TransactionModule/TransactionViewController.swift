//
//  TransactionViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import UIKit
import SnapKit

protocol TransactionViewProtocol: AnyObject {
    
}

final class TransactionViewController: UIViewController {
    var presenter: TransactionPresenterProtocol?
    
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
    
}

private extension TransactionViewController {
    func initialize() {
        view.backgroundColor = UIColor(named: "backColor")
        createNavigation()
    }
    
    func createNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Transaction"
    }
}
