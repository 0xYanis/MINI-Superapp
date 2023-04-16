//
//  BankTableView.swift
//  MINI
//
//  Created by Yan Rybkin on 17.04.2023.
//

import UIKit
import SnapKit

final class BankTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let cardCell = UITableViewCell()
    private let templateCell = UITableViewCell()
}

private extension BankTableView {
    func initialize() {
        delegate = self
        createCardCell()
        createTemplateCell()
    }
    func createCardCell() {
        register(UITableViewCell.self, forCellReuseIdentifier: cardCell.description)
    }
    func createTemplateCell() {
        register(UITableViewCell.self, forCellReuseIdentifier: templateCell.description)
    }
}

extension BankTableView: UITableViewDelegate {
    
}

extension BankTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .white
        return cell
    }
}
