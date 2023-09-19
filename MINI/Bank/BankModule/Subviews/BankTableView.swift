//
//  BankTableView.swift
//  MINI
//
//  Created by Yan Rybkin on 05.06.2023.
//

import UIKit
import SnapKit

protocol BankTableCellConf: AnyObject {
    var presenter: BankPresenterProtocol? { get set }
    func reloadData()
}

final class BankTableView: MiTableView {
    
    weak var presenter: BankPresenterProtocol?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func initialize() {
        backgroundColor = .none
        separatorStyle  = .none
        separatorColor  = .none
        dataSource      = self
        showsVerticalScrollIndicator = false
        register(BankCardSet.self)
        register(BankTemplateLabelCell.self)
        register(BankTemplateSet.self)
    }
    
}

//MARK: - UITableViewDataSource

extension BankTableView: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 3
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch indexPath.row {
        case 0:  return configureCell(BankCardSet.self, indexPath: indexPath)
        case 1:  return configureCell(BankTemplateLabelCell.self, indexPath: indexPath)
        case 2:  return configureCell(BankTemplateSet.self, indexPath: indexPath)
        default: fatalError()
        }
    }
    
    func configureCell<C: BankTableCellConf>(_ cell: C.Type, indexPath: IndexPath) -> C {
        guard let cell = self.dequeueReusableCell(
            withIdentifier: String(describing: cell),
            for: indexPath
        ) as? C else { fatalError() }
        cell.presenter = presenter
        cell.reloadData()
        return cell
    }
    
}
