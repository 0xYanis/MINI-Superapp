//
//  BankViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit
import SnapKit
import FloatingPanel

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
    
    public var presenter: BankPresenterProtocol?
    
    //MARK: - Private properties
    
    private let refreshControl = UIRefreshControl()
    private let bankCollectionView: BankCollectionView = {
        let layout = UICollectionViewLayout()
        let view = BankCollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    private let historyTableVC = BankHistoryViewController()
    private lazy var historyBottomSheet = FloatingPanelController()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.viewDidLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
        tabBarController?.showTabBar()
    }
    
    //MARK: - Private methods
    
    @objc private func refreshAction() {
        presenter?.viewDidLoaded()
    }
    
}

//MARK: - BankViewProtocol

extension BankViewController: BankViewProtocol {
    
    func updateBankTable() {
        bankCollectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func updateHistory() {
        historyTableVC.reloadData()
        refreshControl.endRefreshing()
    }
    
    func loadingDataGetFailed(with error: String) {
        let alert = UIAlertController()
        alert.showAlert(title: "Ошибка", message: error, from: self)
    }
    
}

//MARK: - BankViewCellDelegate

extension BankViewController: BankViewCellDelegate {
    
    func setBigHeightOfHistory() {
        historyBottomSheet.move(to: .full, animated: true)
    }
    
    func resetBottomSheetSize() {
        historyBottomSheet.move(to: .half, animated: true)
    }
    
}

//MARK: - Private methods & computed properties

private extension BankViewController {
    
    func initialize() {
        view.backgroundColor = .back2MINI
        createNavigation(title: "bank_navbar".localized)
        createRefreshControl()
        createBottomSheet()
        createCollectionView()
    }
    
    func createNavigation(title: String) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItems = [addNewItemBarButton, lockViewBarButton]
        navigationItem.title = title
    }
    
    var lockViewBarButton: UIBarButtonItem {
        return UIBarButtonItem(
            image: .init(.lockCircle),
            style: .plain,
            target: self,
            action: #selector(lockViewAction))
    }
    
    @objc func lockViewAction() {
        bankCollectionView.hidePersonalData()
    }
    
    var addNewItemBarButton: UIBarButtonItem {
        return UIBarButtonItem(
            systemItem: .compose,
            primaryAction: .none,
            menu: addNewMenu)
    }
    
    var addNewMenu: UIMenu {
        let addCard = UIAction(
            title: "add_new_card".localized,
            image: .init(.creditcardFill)
        ) { [weak self] _ in
            self?.presenter?.userWantToDetails(of: .newCard, with: 0)
        }
        let addTemplate = UIAction(
            title: "add_new_template".localized,
            image: .init(.plusRectangleFill)
        ) { [weak self] _ in
            self?.presenter?.userWantToDetails(of: .newTemplate, with: 0)
        }
        return UIMenu(children: [addCard, addTemplate])
    }
    
    func createCollectionView() {
        bankCollectionView.presenter = presenter
        view.insertSubview(bankCollectionView, at: 0)
        bankCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func createBottomSheet() {
        historyTableVC.delegate = self
        historyTableVC.presenter = presenter
        historyBottomSheet.set(contentViewController: historyTableVC)
        historyBottomSheet.surfaceView.appearance.cornerRadius = 30
        historyBottomSheet.addPanel(toParent: self, animated: true)
        historyBottomSheet.layout = BankSheetLayout()
        historyBottomSheet.invalidateLayout()
    }
    
    func createRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        bankCollectionView.refreshControl = refreshControl
    }
    
}
