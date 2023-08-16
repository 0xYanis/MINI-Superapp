//
//  NewCardViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit
import SnapKit

protocol NewCardViewProtocol: AnyObject {
    
}

final class NewCardViewController: UIViewController {
    
    var presenter: NewCardPresenterProtocol?
    
    private lazy var cardFormView = CardFormView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
    
}

extension NewCardViewController: NewCardViewProtocol {
    
}

private extension NewCardViewController {
    
    func initialize() {
        view.backgroundColor = .back2MINI
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "add_new_card_title".localized
        createCardFormView()
    }
    
    func createCardFormView() {
        cardFormView.presenter = presenter
        cardFormView.backgroundColor = .clear
        
        view.addSubview(cardFormView)
        cardFormView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
