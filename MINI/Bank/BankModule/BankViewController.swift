//
//  BankViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit
import SnapKit

// MARK: - BankViewProtocol

protocol BankViewProtocol: AnyObject {
    func updateBankTable()
    func updateHistory()
    func loadingDataGetFailed(with error: String)
}

// MARK: - BankViewCellDelegate

protocol BankViewCellDelegate: AnyObject {
    func setBigHeightOfHistory()
    func resetBottomSheetSize()
}

final class BankViewController: UIViewController {
    
    //MARK: - Public properties
    
    var presenter: BankPresenterProtocol?
    
    //MARK: - Private properties
    
    private let bankTableView  = BankTableView()
    private let historyTableVC = BankHistoryViewController()
    private lazy var refreshControl = UIRefreshControl()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.viewDidLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.showTabBar()
    }
    
}

//MARK: - BankViewProtocol

extension BankViewController: BankViewProtocol {
    
    func updateBankTable() {
        bankTableView.reloadData()
    }
    
    func updateHistory() {
        historyTableVC.reloadData()
    }
    
    func loadingDataGetFailed(with error: String) {
        
    }
    
}

//MARK: - BankViewCellDelegate

extension BankViewController: BankViewCellDelegate {
    
    func setBigHeightOfHistory() {
        historyTableVC.view.animateToSuperviewSize()
    }
    
    func resetBottomSheetSize() {
        historyTableVC.view.resetToOriginalState(with: true)
    }
    
}

//MARK: - Private methods

private extension BankViewController {
    
    func initialize() {
        view.backgroundColor = .back2MINI
        createNavigation(title: "bank_navbar".localized)
        createTableView()
        createBottomSheet()
        createRefreshControl(scrollView: bankTableView)
    }
    
    func createNavigation(title: String) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = rightButtonItem
        navigationItem.title = title
    }
    
    var rightButtonItem: UIBarButtonItem {
        return UIBarButtonItem(
            systemItem: .compose,
            primaryAction: .none,
            menu: addNewMenu)
    }
    
    var addNewMenu: UIMenu {
        let addCard = UIAction(
            title: "add_new_card".localized,
            image: .init(systemName: "creditcard.fill")
        ) { [weak self] _ in
            self?.presenter?.userWantToDetails(of: .newCard, with: 0)
        }
        let addTemplate = UIAction(
            title: "add_new_template".localized,
            image: .init(systemName: "plus.rectangle.fill")
        ) { [weak self] _ in
            self?.presenter?.userWantToDetails(of: .newTemplate, with: 0)
        }
        return UIMenu(children: [addCard, addTemplate])
    }
    
    func createTableView() {
        bankTableView.presenter = presenter
        bankTableView.delegate = self
        view.addSubview(bankTableView)
        bankTableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
    }
    
    func createBottomSheet() {
        addChild(historyTableVC)
        view.addSubview(historyTableVC.view)
        historyTableVC.didMove(toParent: self)
        historyTableVC.presenter = presenter
        historyTableVC.delegate = self
        historyTableVC.view.roundCorners(radius: 30)
        historyTableVC.view.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalToSuperview()
                .multipliedBy(0.34)
                .offset(tabBarController?.tabBar.frame.height ?? 0)
        }
    }
    
    func createRefreshControl(scrollView: UIScrollView) {
        refreshControl.addTarget(
            self,
            action: #selector(refreshAction),
            for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
}

//MARK: - Action private methods

private extension BankViewController {
    
    @objc func refreshAction() {
        presenter?.viewDidLoaded()
        presenter?.updateView()
        refreshControl.endRefreshing()
    }
    
}

//MARK: - UITableViewDelegate

extension BankViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        let height = view.frame.height
        switch indexPath.row {
        case 0:
            return (height/5)
        case 1:
            return (height/30)
        case 2:
            return (height/6.3)
        default:
            return 0
        }
    }
    
}
