//
//  ProfileTableView.swift
//  MINI
//
//  Created by Yan Rybkin on 16.06.2023.
//

import UIKit
import SnapKit

final class ProfileTableView: UITableView {
    
    weak var presenter: ProfilePresenterProtocol?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .insetGrouped)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfileTableView {
    func initialize() {
        dataSource = self
        delegate = self
        backgroundColor = .clear
        register(
            ProfileTableCell.self,
            forCellReuseIdentifier: ProfileTableCell.cellId
        )
    }
}

extension ProfileTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter?
            .getProfileData()
            .count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        presenter?
            .getProfileData()[section]
            .options
            .count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileTableCell.cellId,
            for: indexPath
        ) as? ProfileTableCell,
              let data = presenter?
            .getProfileData()[indexPath.section]
            .options[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configure(with: data)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        presenter?
            .getProfileData()[section]
            .title
    }
}

extension ProfileTableView: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard let type = presenter?
            .getProfileData()[indexPath.section]
            .options[indexPath.row]
            .type else { return }
        presenter?.userWantToDetailView(of: type)
    }
}
