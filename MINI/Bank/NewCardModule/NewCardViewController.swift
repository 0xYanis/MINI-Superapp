//
//  NewCardViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import UIKit

protocol NewCardViewProtocol: AnyObject {
    
}

final class NewCardViewController: UIViewController {
    var presenter: NewCardPresenterProtocol?
    
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
        view.backgroundColor = .white
    }
}
