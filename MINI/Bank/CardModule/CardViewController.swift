//
//  CardViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit

protocol CardViewProtocol: AnyObject {
    
}

final class CardViewController: UIViewController {
    var presenter: CardPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
    
    private let cardTableView = UITableView()
}

extension CardViewController: CardViewProtocol {
    
}

private extension CardViewController {
    func initialize() {
        view.backgroundColor = .white
        createNavigation()
    }
    
    func createNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Visa Classic"
    }
    
    func createCardTableView() {
        cardTableView.isScrollEnabled = false
        cardTableView.backgroundColor = .clear
        cardTableView.separatorColor = .clear
        cardTableView.showsVerticalScrollIndicator = false
        view.addSubview(cardTableView)
        cardTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func cardTableViewRegister() {
        cardTableView.register(CardDetailView.self, forCellReuseIdentifier: CardDetailView.cellId)
    }
}
