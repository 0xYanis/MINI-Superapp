//
//  BankViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit
import SnapKit

protocol BankViewCellDelegate: AnyObject {
    func handleTapOnCardCell(id: Int)
    func handleTapOnTemplateCell(id: Int)
    func handleTapOnTransactionCell(id: Int)
    func handleTapOnSeeHistoryCell()
}

protocol BankViewProtocol: AnyObject {
    func updateCards()
    func updateHistory()
    func configureView()
}

final class BankViewController: UIViewController {
    
    var presenter: BankPresenterProtocol?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.showTabBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.dismiss(animated: false)
    }
    
    //MARK: Private properties
    private let bankTableView = UITableView()
    private let historyTableVC = BankHistoryTableViewController()
}

//MARK: - BankViewProtocol
extension BankViewController: BankViewProtocol {
    func updateCards() {
        
    }
    
    func updateHistory() {
        
    }
    
    func configureView() {
        
    }
}

//MARK: - BankViewCellDelegate
extension BankViewController: BankViewCellDelegate {
    func handleTapOnCardCell(id: Int) {
        presenter?.userDidTapCard(id: id)
    }
    
    func handleTapOnTemplateCell(id: Int) {
        presenter?.userDidTapTemplate(id: id)
    }
    
    func handleTapOnTransactionCell(id: Int) {
        presenter?.userDidTapTransaction(id: id)
    }
    
    func handleTapOnSeeHistoryCell() {
        createBottomSheet()
    }
}

//MARK: - Private methods
private extension BankViewController {
    func initialize() {
        view.backgroundColor = UIColor(named: "backColor")
        createNavigation()
        createBankTableView()
    }
    
    func createNavigation() {
        navigationItem.title = "Home"
        navigationItem.rightBarButtonItem = createRightBarButtonItem()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func createRightBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(systemItem: .edit,
                               primaryAction: .none,
                               menu: createRightMenu()
        )
    }
    
    func createRightMenu() -> UIMenu {
        let cardImage = UIImage(systemName: "creditcard.fill")
        let addCard = UIAction(title: "Add new Card", image: cardImage) { [weak self] _ in
            self?.presenter?.userDidTapNewCard()
        }
        let templateImage = UIImage(systemName: "plus.rectangle.fill")
        let addTemplate = UIAction(title: "Add new Template", image: templateImage) { [weak self] _ in
            self?.presenter?.userDidTapNewTemplate()
        }
        let menu = UIMenu(children: [
            addCard, addTemplate
        ])
        return menu
    }
    
    func createBankTableView() {
        bankTableView.isScrollEnabled = false
        bankTableView.backgroundColor = .clear
        bankTableView.separatorColor = .clear
        bankTableView.dataSource = self
        bankTableView.delegate = self
        bankTableView.showsVerticalScrollIndicator = false
        bankTableView.backgroundColor = UIColor(named: "backColor")
        bankTableView.register(BankCardSet.self, forCellReuseIdentifier: BankCardSet.cellId)
        bankTableView.register(BankTemplateLabelCell.self, forCellReuseIdentifier: BankTemplateLabelCell.cellId)
        bankTableView.register(BankTemplateSet.self, forCellReuseIdentifier: BankTemplateSet.cellId)
        bankTableView.register(BankHistoryLabelCell.self, forCellReuseIdentifier: BankHistoryLabelCell.cellId)
        view.addSubview(bankTableView)
        bankTableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
    }
    
    func createBottomSheet() {
        let height = view.frame.height * 0.35
        let smallId = UISheetPresentationController.Detent.Identifier("smallId")
        let smallDetent = UISheetPresentationController.Detent.custom(
            identifier: smallId) { context in
                return height
            }
        historyTableVC.delegate = self
        if let sheet = historyTableVC.sheetPresentationController {
            sheet.detents = [smallDetent, .large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = smallId
            sheet.preferredCornerRadius = 30
        }
        navigationController?.present(historyTableVC, animated: true)
    }
}

//MARK: - Action private methods
private extension BankViewController {
    @objc func didTapSeeAllButt() {
        presenter?.userDidTapSeeAll()
    }
}

//MARK: - UITableViewDataSource
extension BankViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BankCardSet.cellId,
                for: indexPath) as? BankCardSet else { return defaultCell }
            cell.configure()
            cell.delegate = self
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BankTemplateLabelCell.cellId,
                for: indexPath) as? BankTemplateLabelCell else { return defaultCell }
            cell.seeAllButt.addTarget(self, action: #selector(didTapSeeAllButt), for: .touchUpInside)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BankTemplateSet.cellId,
                for: indexPath) as? BankTemplateSet else { return defaultCell }
            cell.delegate = self
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BankHistoryLabelCell.cellId,
                for: indexPath) as? BankHistoryLabelCell else { return defaultCell }
            cell.delegate = self
            return cell
        default:
            return defaultCell
        }
    }
}

//MARK: - UITableViewDelegate
extension BankViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = view.frame.height
        switch indexPath.row {
        case 0:
            return (height/4.7)
        case 1:
            return (height/18)
        case 2:
            return (height/6.3)
        case 3:
            return (height/18)
        default:
            return (height/4.7)
        }
    }
}
