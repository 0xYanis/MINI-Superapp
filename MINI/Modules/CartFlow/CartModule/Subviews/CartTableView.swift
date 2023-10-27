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
    public weak var purchaseDelegate: PurchaseCellDelegate?
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
        register(CartTagCell.self)
        register(PurchaseCell.self)
        showsVerticalScrollIndicator = false
        sectionHeaderTopPadding = 0
        backgroundColor = .clear
        separatorStyle = .none
        dataSource = self
        delegate = self
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
        titleForHeaderInSection section: Int
    ) -> String? {
        if section == 1 {
            let count = presenter?.getPurchases().count ?? 0
            return count > 0 ? "Ваша корзина" : nil
        }
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        if section == 0 { return 1 }
        return presenter?.getPurchases().count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = addCell(CartTagCell.self, indexPath: indexPath)
            cell.pickerDelegate = self
            cell.configure(with: presenter?.getTagItems() ?? [])
            return cell
        } else {
            let cell = addCell(PurchaseCell.self, indexPath: indexPath)
            guard let data = presenter?.getPurchases()[indexPath.row]
            else { return UITableViewCell() }
            cell.configure(with: data)
            cell.delegate = purchaseDelegate
            return cell
        }
    }
    
}

// MARK: - UITableViewDelegate

extension CartTableView: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        indexPath.section == 0 ? 38 : 140
    }
    
    // MARK: Swipe methods
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        if indexPath.section == 0 { return nil }
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
        action.image = .init(.trash)
        action.backgroundColor = .systemOrange
        return action
    }
    
    func tableView(
        _ tableView: UITableView,
        didHighlightRowAt indexPath: IndexPath
    ) {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? PurchaseCell
        else { return }
        UIView.animate(withDuration: 0.2) {
            cell.cellColor = .systemGray3
            cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        didUnhighlightRowAt indexPath: IndexPath
    ) {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? PurchaseCell
        else { return }
        UIView.animate(withDuration: 0.2) {
            cell.cellColor = .systemBackground
            cell.transform = .identity
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
