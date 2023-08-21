//
//  PayoutsView.swift
//  MINI
//
//  Created by Yan Rybkin on 21.08.2023.
//

import UIKit

final class PayoutsView: UIView {
    
    private lazy var tableView = MiTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func safeAreaInsetsDidChange() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func updateView() {
        tableView.reloadData()
    }
    
}

private extension PayoutsView {
    
    func initialize() {
        backgroundColor = .clear
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            PayoutsCell.self,
            cellId: PayoutsCell.cellId
        )
    }
    
}

extension PayoutsView: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 15
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PayoutsCell.cellId,
            for: indexPath) as? PayoutsCell
        else { return UITableViewCell() }
        cell.configure(with: .init(image: "", title: "", description: ""))
        return cell
    }
    
}

extension PayoutsView: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        estimatedHeightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}