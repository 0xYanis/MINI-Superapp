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
    
    private let cardTableView = UITableView()
    
    var presenter: CardPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
}

extension CardViewController: CardViewProtocol {
    
}

private extension CardViewController {
    func initialize() {
        view.backgroundColor = UIColor(named: "backColor")
        createNavigation()
        cardTableViewRegister()
    }
    
    func createNavigation() {
        navigationItem.title = "Visa Classic"
    }
    
    func createCardTableView() {
        cardTableView.backgroundColor = .clear
        cardTableView.separatorColor = .clear
        cardTableView.showsVerticalScrollIndicator = false
        cardTableView.delegate = self
        
        view.addSubview(cardTableView)
        cardTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func cardTableViewRegister() {
        cardTableView.register(CardDetailViewCell.self, forCellReuseIdentifier: CardDetailViewCell.cellId)
    }
}

extension CardViewController: UITableViewDelegate {
    
}

extension CardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CardDetailViewCell.cellId,
                for: indexPath) as? CardDetailViewCell else { return defaultCell }
            return cell
        default:
            return defaultCell
        }
    }
}
