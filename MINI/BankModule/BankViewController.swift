//
//  BankViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import UIKit
import SnapKit

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
    
    private let bankTableView = UITableView()
    private let historyTableVC = BankHistoryTableViewController()
}

extension BankViewController: BankViewProtocol {
    func updateCards() {
        
    }
    
    func updateHistory() {
        
    }
    
    func configureView() {
        
    }
}

private extension BankViewController {
    func initialize() {
        view.backgroundColor = UIColor(named: "backColor")
        createNavigation()
        createBankTableView()
        createBottomSheet()
    }
    
    func createNavigation() {
        navigationItem.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func createBankTableView() {
        bankTableView.separatorColor = .clear
        bankTableView.dataSource = self
        bankTableView.delegate = self
        bankTableView.showsVerticalScrollIndicator = false
        bankTableView.backgroundColor = UIColor(named: "backColor")
        bankTableView.register(BankCardCell.self, forCellReuseIdentifier: BankCardCell.cellId)
        bankTableView.register(BankTemplateCell.self, forCellReuseIdentifier: BankTemplateCell.cellId)
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

extension BankViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BankCardCell.cellId,
                for: indexPath) as? BankCardCell else { return defaultCell }
            cell.layoutIfNeeded()
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BankTemplateCell.cellId,
                for: indexPath) as? BankTemplateCell else { return defaultCell }
            cell.layoutIfNeeded()
            return cell
        default:
            return defaultCell
        }
    }
}

extension BankViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
