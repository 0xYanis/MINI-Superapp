//
//  BankHistoryViewController.swift
//  MINI
//
//  Created by Yan Rybkin on 18.04.2023.
//

import UIKit
import SnapKit

final class BankHistoryViewController: UIViewController {
    
    private let labelView = BankHistoryLabel()
    private let tableView = UITableView()
    
    weak var delegate: BankViewCellDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialize()
    }
    
}

//MARK: - Private methods
private extension BankHistoryViewController {
    func intialize() {
        self.modalPresentationStyle = .overCurrentContext
        createSeeAllLabel()
        createTableView()
    }
    
    func createSeeAllLabel() {
        labelView.backgroundColor = .black
        view.addSubview(labelView)
        labelView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(60)
        }
        addGestureForLabel()
    }
    
    func addGestureForLabel() {
        let swipeUpGesture = UISwipeGestureRecognizer(
            target: self,
            action: #selector(setBigHeight)
        )
        swipeUpGesture.direction = .up
        labelView.addGestureRecognizer(swipeUpGesture)
        let swipeDownGesture = UISwipeGestureRecognizer(
            target: self,
            action: #selector(resetToOriginalState)
        )
        swipeDownGesture.direction = .down
        labelView.addGestureRecognizer(swipeDownGesture)
    }
    
    func createTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableViewRegister()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(labelView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func tableViewRegister() {
        tableView.register(
            BankTransactionCell.self,
            forCellReuseIdentifier: BankTransactionCell.cellId
        )
    }
    
    @objc func resetToOriginalState() {
        delegate?.resetBottomSheetSize()
    }
    
    @objc func setBigHeight() {
        delegate?.handleTapOnSeeHistoryCell()
    }
}

//MARK: - UITableViewDataSource
extension BankHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BankTransactionCell.cellId,
            for: indexPath) as? BankTransactionCell else { return defaultCell }
        cell.layoutIfNeeded()
        return cell
    }
}

//MARK: - UITableViewDelegate
extension BankHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.handleTapOnTransactionCell(id: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
