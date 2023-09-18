//
//  PayoutsView.swift
//  MINI
//
//  Created by Yan Rybkin on 21.08.2023.
//

import UIKit

final class PayoutsView: UIView {
    
    var presenter: PayoutsPresenterProtocol?
    
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
        tableView.register(PayoutsCell.self)
    }
    
}

extension PayoutsView: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return presenter?.getData().count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PayoutsCell.cellId,
            for: indexPath) as? PayoutsCell,
              
              let data = presenter?.getData()[indexPath.row]
        else { return UITableViewCell() }
        
        cell.configure(with: data)
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
    
    func tableView(
        _ tableView: UITableView,
        didDeselectRowAt indexPath: IndexPath
    ) {
        presenter?.didTapToPush(with: indexPath.row)
    }
    
}
