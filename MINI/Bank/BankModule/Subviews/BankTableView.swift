//
//  BankTableView.swift
//  MINI
//
//  Created by Yan Rybkin on 05.06.2023.
//

import UIKit
import SnapKit

protocol BankTableCellConf: AnyObject {
    static var cellId: String { get }
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
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}

private extension BankTableView {
    
    func initialize() {
        separatorStyle = .none
        separatorColor = .none
        backgroundColor = .none
        dataSource = self
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        
        tableViewRegisters()
    }
    
    func tableViewRegisters() {
        register(BankCardSet.self,
                 cellId: BankCardSet.cellId)
        register(BankTemplateLabelCell.self,
                 cellId: BankTemplateLabelCell.cellId)
        register(BankTemplateSet.self,
                 cellId: BankTemplateSet.cellId)
    }
    
}

//MARK: - UITableViewDataSource
extension BankTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            return configureCell(BankCardSet.self, indexPath: indexPath)
        case 1:
            return configureCell(BankTemplateLabelCell.self, indexPath: indexPath)
        case 2:
            return configureCell(BankTemplateSet.self, indexPath: indexPath)
        default:
            return defaultCell
        }
    }
    
    func configureCell<C: BankTableCellConf>(_ cell: C.Type, indexPath: IndexPath) -> C {
        guard let cell = self.dequeueReusableCell(
            withIdentifier: C.cellId,
            for: indexPath
        ) as? C else { fatalError("") }
        cell.presenter = presenter
        cell.reloadData()
        return cell
    }
    
}
