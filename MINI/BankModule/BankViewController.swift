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
}

protocol BankViewProtocol: AnyObject {
    func updateCards()
    func updateHistory()
    func configureView()
}

final class BankViewController: UIViewController {
    
    var presenter: BankPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        createBottomSheet()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.dismiss(animated: false)
    }
    
    
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
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func createBankTableView() {
        bankTableView.backgroundColor = .clear
        bankTableView.separatorColor = .clear
        bankTableView.dataSource = self
        bankTableView.delegate = self
        bankTableView.showsVerticalScrollIndicator = false
        bankTableView.backgroundColor = UIColor(named: "backColor")
        bankTableView.register(BankCardSet.self, forCellReuseIdentifier: BankCardSet.cellId)
        bankTableView.register(BankTemplateLabelCell.self, forCellReuseIdentifier: BankTemplateLabelCell.cellId)
        bankTableView.register(BankTemplateSet.self, forCellReuseIdentifier: BankTemplateSet.cellId)
        view.addSubview(bankTableView)
        bankTableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.65)
        }
    }
    func createBottomSheet() {
        let height = view.frame.height * 0.35
        let smallId = UISheetPresentationController.Detent.Identifier("smallId")
        let smallDetent = UISheetPresentationController.Detent.custom(
            identifier: smallId) { context in
                return height
            }
        historyTableVC.isModalInPresentation = true
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
        return 3
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
        default:
            return (height/4.7)
        }
    }
}
