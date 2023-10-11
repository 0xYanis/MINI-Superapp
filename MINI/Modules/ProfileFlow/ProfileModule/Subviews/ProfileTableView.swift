//
//  ProfileTableView.swift
//  MINI
//
//  Created by Yan Rybkin on 16.06.2023.
//

import UIKit
import SnapKit

final class ProfileTableView: MiTableView {
    
    weak var presenter: ProfilePresenterProtocol?
    
    override init(frame: CGRect = .zero, style: UITableView.Style) {
        super.init(style: style)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

private extension ProfileTableView {
    
    func initialize() {
        rowHeight = 44
        estimatedRowHeight = 44
        sectionHeaderTopPadding = 0
        dataSource = self
        delegate = self
        backgroundColor = .clear
        register(ProfileTableCell.self)
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
        let cell = addCell(ProfileTableCell.self, indexPath: indexPath)
        guard let data = presenter?
            .getProfileData()[indexPath.section]
            .options[indexPath.row]
        else { return UITableViewCell() }
        cell.configure(with: data, indexPath.row)
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
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        if section == 0 {
            let header = ProfileHeader()
            let userData = presenter?.getUserData()
            header.configure(
                name: userData?.name ?? "User",
                address: userData?.address ?? "None"
            )
            return header
        }
        return nil
    }
    
}

extension ProfileTableView: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let type = presenter?
            .getProfileData()[indexPath.section]
            .options[indexPath.row]
            .type else { return }
        presenter?.userWantToDetailView(of: type)
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        section == 0 ? 150 : tableView.sectionHeaderHeight
    }
    
}
