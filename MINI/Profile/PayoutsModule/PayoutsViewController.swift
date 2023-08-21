//
//  PayoutsViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 18.08.2023.
//

import UIKit
import SnapKit

protocol PayoutsViewProtocol: AnyObject {
    
}

final class PayoutsViewController: UIViewController {
    
    var presenter: PayoutsPresenterProtocol?
    
    private lazy var emptyView = EmptyPayoutsView()
    private lazy var payoutsView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .back2MINI
        presenter?.viewDidLoaded()
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        emptyView.configure(message: "Упс!", "Похоже, здесь ничего нет..")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
    
}

extension PayoutsViewController: PayoutsViewProtocol {
    
}
