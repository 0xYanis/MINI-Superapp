//
//  PayoutsViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 18.08.2023.
//

import UIKit
import SnapKit

protocol PayoutsViewProtocol: AnyObject {
    func setTitle(_ title: String)
    func setView(with data: [PayoutsModel])
}

final class PayoutsViewController: UIViewController {
    
    var presenter: PayoutsPresenterProtocol?
    
    private lazy var emptyView   = EmptyPayoutsView()
    private lazy var payoutsView = PayoutsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.viewDidLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
    
}

extension PayoutsViewController: PayoutsViewProtocol {
    
    func setTitle(_ title: String) {
        navigationItem.title = title
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setView(with data: [PayoutsModel]) {
        if data.isEmpty {
            createEmptyView()
        } else {
            createPayoutsView()
        }
    }
    
}

private extension PayoutsViewController {
    
    func initialize() {
        view.backgroundColor = .back2MINI
    }
    
    func createEmptyView() {
        emptyView.configure(
            message: "Упс!",
            "Похоже, здесь ничего нет..")
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func createPayoutsView() {
        view.addSubview(payoutsView)
        payoutsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
