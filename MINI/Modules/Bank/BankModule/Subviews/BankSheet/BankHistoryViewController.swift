//
//  BankHistoryViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 18.04.2023.
//

import UIKit
import SnapKit

final class BankHistoryViewController: UIViewController {
    
    weak var delegate: BankViewCellDelegate?
    weak var presenter: BankPresenterProtocol?
    
    private let indicator = UIActivityIndicatorView(style: .medium)
    private let labelView = BankHistoryLabel()
    private let tableView = MiTableView()
    private var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialize()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
}

//MARK: - Private methods
private extension BankHistoryViewController {
    
    func intialize() {
        view.backgroundColor = .backMINI
        createSearchLabel()
        createTableView()
        createIndicator()
    }
    
    func createSearchLabel() {
        labelView.delegate = self
        labelView.backgroundColor = .backMINI
        view.insertSubview(labelView, at: 1)
        labelView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    func createTableView() {
        tableView.backgroundColor = .backMINI
        tableView.rowHeight = 100
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        view.insertSubview(tableView, at: 0)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(labelView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        tableView.register(BankTransactionCell.self)
    }
    
    func createIndicator() {
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        view.insertSubview(indicator, at: 2)
        indicator.center = view.center
        indicator.snp.makeConstraints { make in
            make.top.equalTo(labelView.snp.bottom).offset(70)
            make.centerX.equalToSuperview()
        }
    }

}

//MARK: - BankTransactionKeyboardDelegate
extension BankHistoryViewController: BankTransactionKeyboardDelegate {
    
    func userDidBeginUseKeyboard() {
        delegate?.setBigHeightOfHistory()
    }
    
    func userDidEndUseKeyboard() {
        delegate?.resetBottomSheetSize()
        isSearching = false
        tableView.reloadData()
    }
    
    func searchBarTextDidChange(with searchText: String) {
        indicator.startAnimating()
        if !searchText.isEmpty {
            presenter?.searchBarTextDidChange(with: searchText)
            isSearching = true
            tableView.reloadData()
        } else {
            isSearching = false
            tableView.reloadData()
        }
    }
    
}

//MARK: - UITableViewDataSource
extension BankHistoryViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        let filteredCounter = presenter?.getFilteredData().count
        let transanctionCounter = presenter?.getTransactionData().count
        let actualNumber = (isSearching ? filteredCounter : transanctionCounter) ?? 0
        actualNumber == 0 ? indicator.startAnimating() : indicator.stopAnimating()
        return actualNumber
    }
    
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: BankTransactionCell.self),
            for: indexPath
        ) as? BankTransactionCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        guard let data = isSearching ? presenter?.getFilteredData() : presenter?.getTransactionData() else { return }
        
        if let cell = cell as? BankTransactionCell {
            cell.configure(with: data[indexPath.row])
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        
        let deleteAction = deleteCellsAction(tableView, indexPath: indexPath)
        
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil
        ) { _ in
            UIMenu(
                title: "",
                children: [deleteAction]
            )
        }
    }
    
    func deleteCellsAction(
        _ tableView: UITableView,
        indexPath: IndexPath
    ) -> UIAction {
        let deleteAction = UIAction(
            title: "Удалить",
            image: UIImage(systemName: "trash"),
            attributes: .destructive
        ) { [weak self] _ in
            self?.presenter?.userWantToDeleteTransaction(at: indexPath.row)
            tableView.performBatchUpdates({
                tableView.deleteRows(at: [indexPath], with: .middle)
            })
        }
        
        return deleteAction
    }
    
}

//MARK: - UITableViewDelegate
extension BankHistoryViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let index = indexPath.row
        presenter?.userWantToDetails(of: .transaction, with: index)
    }
    
}