//
//  BankViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit
import SnapKit

protocol BankViewProtocol: AnyObject {
    func updateBankTable()
    func updateHistory()
    
    func loadingDataGetFailed(with error: String)
}

protocol BankViewCellDelegate: AnyObject {
    func handlePanGesture(_ gesture: UIPanGestureRecognizer)
    func setBigHeightOfHistory()
    func resetBottomSheetSize()
}

final class BankViewController: UIViewController {
    
    //MARK: Public properties
    var presenter: BankPresenterProtocol?
    
    //MARK: Private properties
    private lazy var backgroundView = UIView()
    private lazy var bankTableView  = BankTableView()
    private lazy var historyTableVC = BankHistoryViewController()
    private lazy var refreshControl = UIRefreshControl()
    
    private lazy var height: CGFloat    = view.frame.height
    private lazy var minHeight: CGFloat = 0.34 * view.frame.height + view.safeAreaInsets.bottom
    private lazy var maxHeight: CGFloat = view.frame.height - view.safeAreaInsets.top
    
    
    //MARK: Lifecycle
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
    func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        ///
    }
    
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
        view.backgroundColor = UIColor(named: "backColor")
        createNavigation(title: "bank_navbar".localized)
        createBackgroundView()
        createTableView()
        createBottomSheet()
        createRefreshControl(scrollView: bankTableView)
    }
    
    func createNavigation(title: String) {
        navigationItem.title = title
        navigationItem.rightBarButtonItem = createRightBarButtonItem
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    var createRightBarButtonItem: UIBarButtonItem {
        return UIBarButtonItem(
            systemItem: .compose,
            primaryAction: .none,
            menu: createRightMenu
        )
    }
    
    var createRightMenu: UIMenu {
        let cardImage = UIImage(systemName: "creditcard.fill")
        let addCard = UIAction(
            title: "add_new_card".localized,
            image: cardImage) { [weak self] _ in
                self?.presenter?.userDidTapNewCard()
            }
        let templateImage = UIImage(systemName: "plus.rectangle.fill")
        let addTemplate = UIAction(
            title: "add_new_template".localized,
            image: templateImage) { [weak self] _ in
                self?.presenter?.userDidTapNewTemplate()
            }
        return UIMenu(children: [addCard, addTemplate])
    }
    
    func createBackgroundView() {
        backgroundView.backgroundColor = .systemGray4
        backgroundView.radiusAndShadow(
            radius: 30,
            color: .black,
            opacity: 0.5,
            shadowSize: 30
        )
        
        view.insertSubview(backgroundView, at: 0)
        backgroundView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.5)
            make.center.width.equalToSuperview()
        }
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
        historyTableVC.view.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.34)
                .offset(tabBarController?.tabBar.frame.height ?? 0)
        }
        historyTableVC.view.layer.cornerRadius = 30
        historyTableVC.view.clipsToBounds = true
    }
    
    func createRefreshControl(scrollView: UIScrollView) {
        refreshControl.addTarget(
            self,
            action: #selector(refreshAction),
            for: .valueChanged
        )
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
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = view.frame.height
        switch indexPath.row {
        case 0:
            return (height/5)
        case 1:
            return (height/30)
        case 2:
            return (height/6.3)
        default:
            return UITableView.automaticDimension
        }
    }
}
