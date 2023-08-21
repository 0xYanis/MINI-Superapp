//
//  PayoutsViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 18.08.2023.
//

import UIKit
import SnapKit

protocol PayoutsViewProtocol: AnyObject {
    func updateView()
    func setTitle(_ title: String)
}

final class PayoutsViewController: UIViewController {
    
    var presenter: PayoutsPresenterProtocol?
    
    private lazy var emptyView   = EmptyPayoutsView()
    private lazy var payoutsView = PayoutsView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
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
    
    func updateView() {
        checkForEmptyData()
        payoutsView.updateView()
    }
    
}

private extension PayoutsViewController {
    
    func initialize() {
        view.backgroundColor = .back2MINI
        checkForEmptyData()
        createEmptyView()
        createPayoutsView()
    }
    
    func checkForEmptyData() {
        if let _ = presenter?.getData().isEmpty {
            emptyView.isHidden = false
            payoutsView.isHidden = true
        } else {
            emptyView.isHidden = true
            payoutsView.isHidden = false
        }
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
        emptyView.isHidden = false
    }
    
    func createPayoutsView() {
        payoutsView.isHidden = false
        view.addSubview(payoutsView)
        payoutsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
