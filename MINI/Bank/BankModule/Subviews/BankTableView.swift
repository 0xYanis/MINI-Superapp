//
//  BankTableView.swift
//  MINI
//
//  Created by Yan Rybkin on 05.06.2023.
//

import UIKit
import SnapKit

final class BankTableView: UITableView {
    
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
        register(BankCardSet.self, forCellReuseIdentifier: BankCardSet.cellId)
        register(BankTemplateLabelCell.self, forCellReuseIdentifier: BankTemplateLabelCell.cellId)
        register(BankTemplateSet.self, forCellReuseIdentifier: BankTemplateSet.cellId)
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
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BankCardSet.cellId,
                for: indexPath) as? BankCardSet else { return defaultCell }
            cell.presenter = presenter
            cell.reloadData()
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BankTemplateLabelCell.cellId,
                for: indexPath) as? BankTemplateLabelCell else { return defaultCell }
            cell.presenter = presenter
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: BankTemplateSet.cellId,
                for: indexPath) as? BankTemplateSet else { return defaultCell }
            cell.presenter = presenter
            cell.reloadData()
            return cell
            
        default:
            return defaultCell
        }
    }
}
