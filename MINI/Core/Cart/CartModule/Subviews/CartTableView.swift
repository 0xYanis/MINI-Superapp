//
//  CartTableView.swift
//  MINI
//
//  Created by Yan Rybkin on 06.09.2023.
//

import UIKit

protocol CartTableScrollDelegate: AnyObject {
    func scrollViewWillBeginDragging()
    func scrollViewDidEndDecelerating()
}

final class CartTableView: MiTableView {
    
    // MARK: - Public properties
    
    public var presenter: CartPresenterProtocol?
    public weak var scrollDelegate: CartTableScrollDelegate?
    
    // MARK: - Initializers
    
    override init(frame: CGRect = .zero, style: UITableView.Style) {
        super.init(style: .grouped)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

// MARK: - Private methods

private extension CartTableView {
    
    func initialize() {
        register(PurchaseCell.self)
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        separatorStyle = .none
        contentInset = .init(top: 20, left: 0, bottom: 50, right: 0)
        
        dataSource = self
        delegate = self
        
        rowHeight = 140
    }
    
}

// MARK: - UITagPickerDataSource

extension CartTableView: UITagPickerDelegate {
    
    func didTap(on index: Int) {
        presenter?.setCurrentTag(index)
    }
    
}

// MARK: - UITableViewDataSource

extension CartTableView: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return presenter?.getPurchases().count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = addCell(PurchaseCell.self, indexPath: indexPath)
        guard let data = presenter?.getPurchases()[indexPath.row]
        else { return UITableViewCell() }
        cell.configure(with: data)
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension CartTableView: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        guard
            let items = presenter?.getTagItems()
        else { return nil }
        let header = UITagPickerView(items)
        header.pickerDelegate = self
        return header
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        38
    }
    
    // MARK: Swipe methods
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = deleteSwipeAction(indexPath)
        return .init(actions: [deleteAction])
    }
    
    private func deleteSwipeAction(_ indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(
            style: .destructive,
            title: "Удалить"
        ) { [weak self] _, _, completion in
            self?.presenter?.deleteCell(at: indexPath.row)
            completion(true)
            self?.deleteRows(at: [indexPath], with: .none)
        }
        action.image = .init(systemName: "trash")
        action.backgroundColor = .systemOrange
        return action
    }
    
    // MARK: ContextMenu methods
    
    func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        let contextMenu = UIContextMenuConfiguration(actionProvider:  { [weak self] (actions) -> UIMenu? in
            guard let self = self else { return nil }
            let share = self.shareAction(at: indexPath.row)
            return UIMenu(title: "Контекстное меню", children: [share])
        })
        
        return contextMenu
    }

    
    private func shareAction(at row: Int) -> UIAction {
        return UIAction(
            title: "Поделиться",
            image: .init(systemName: "square.and.arrow.up")
        ) { _ in
            print("share with row: \(row)")
        }
    }
    
    // MARK: Scroll methods
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewWillBeginDragging()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidEndDecelerating()
    }
    
}
