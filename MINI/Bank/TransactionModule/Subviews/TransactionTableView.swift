//
//  TransactionTableView.swift
//  MINI
//
//  Created by Yan Rybkin on 26.09.2023.
//

import UIKit
import SDWebImage

final class TransactionTableView: MiTableView {
    
    override init(frame: CGRect = .zero, style: UITableView.Style) {
        super.init(style: style)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with data: BankTransactionEntity) {
//        guard let image = SDImageCache.shared.imageFromCache(
//            forKey: data.icon
//        ) else { return }
//        imageView.image = image
    }
    
    private func initialize() {
        dataSource = self
        delegate = self
    }
    
}

// MARK: - UITableViewDataSource

extension TransactionTableView: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 10
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "There is a cell #\(indexPath.row + 1)."
        cell.detailTextLabel?.text = "This cell is in 1 section"
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension TransactionTableView: UITableViewDelegate {
    
}
