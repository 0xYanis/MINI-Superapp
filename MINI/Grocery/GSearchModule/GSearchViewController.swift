//
//  GSearchViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 22.06.2023.
//

import UIKit
import SnapKit

protocol GSearchViewProtocol: AnyObject {
    func updateView()
    func updateViewGetFailed(with message: String)
}

final class GSearchViewController: UIViewController {
    
    var presenter: GSearchPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
}

extension GSearchViewController: GSearchViewProtocol {
    func updateView() {
        
    }
    
    func updateViewGetFailed(with message: String) {
        
    }
}

private extension GSearchViewController {
    func initialize() {
        view.backgroundColor = .back2MINI
    }
}
