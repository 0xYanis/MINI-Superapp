//
//  TransactionTableView.swift
//  MINI
//
//  Created by Yan Rybkin on 26.09.2023.
//

import UIKit
import SDWebImage

final class TransactionTableView: MiTableView {
    
    private let imageView  = UIImageView()
    private let headerView = UIView()
    
    override init(frame: CGRect = .zero, style: UITableView.Style) {
        super.init(style: style)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with data: Transaction) {
        guard let image = SDImageCache.shared.imageFromCache(
            forKey: data.icon
        ) else { return }
        imageView.image = image
    }
    
    private func initialize() {
        configureHeader()
        sectionHeaderTopPadding = 0
        sectionHeaderHeight = 200
        dataSource = self
        delegate = self
    }
    
    private func configureHeader() {
        imageView.contentMode = .scaleAspectFill
        headerView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
        cell.textLabel?.text = "Cell #\(indexPath.row + 1)."
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension TransactionTableView: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        section == 0 ? 200 : 0
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        section == 0 ? headerView : nil
    }
    
}
