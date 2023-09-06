//
//  CartTableView.swift
//  MINI
//
//  Created by Yan Rybkin on 06.09.2023.
//

import UIKit

final class CartTableView: MiTableView {
    
    // MARK: - Public properties
    
    public var presenter: CartPresenterProtocol?
    
    override init(frame: CGRect = .zero, style: UITableView.Style) {
        super.init(style: style)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

private extension CartTableView {
    
    func initialize() {
        register(PurchaseCell.self, cellId: String(describing: PurchaseCell.self))
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        separatorStyle = .none
        
        dataSource = self
        delegate = self
        
        rowHeight = 140
    }
    
}

extension CartTableView: UITableViewDataSource {
    
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
        return tableView.dequeueReusableCell(
            withIdentifier: String(describing: PurchaseCell.self),
            for: indexPath
        )
    }
    
}

extension CartTableView: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = deleteSwipeAction(for: indexPath.row)
        return .init(actions: [deleteAction])
    }
    
    func deleteSwipeAction(for row: Int) -> UIContextualAction {
        let action = UIContextualAction(
            style: .destructive,
            title: "Удалить"
        ) { _, _, completion in
            completion(true)
        }
        action.image = .init(systemName: "trash")
        action.backgroundColor = .systemOrange
        return action
    }
    
    func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(actionProvider: { _ in
            UIMenu(
                title: "Контекстное меню",
                children: []
            )
        })
    }
    
}
