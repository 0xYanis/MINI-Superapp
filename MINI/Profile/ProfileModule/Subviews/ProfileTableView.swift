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
    var profileHeader: ProfileHeader?
    
    override init(frame: CGRect = .zero, style: UITableView.Style) {
        super.init(style: style)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        register(
            ProfileTableCell.self,
            cellId: ProfileTableCell.cellId
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
            for: indexPath) as? ProfileTableCell,
              let data = presenter?
            .getProfileData()[indexPath.section]
            .options[indexPath.row]
        else { return UITableViewCell() }
        
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
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let header = ProfileHeader()
        
        header.configure(
            name: presenter?.getUserData().name ?? "User",
            address: presenter?.getUserData().address ?? "Nil"
        )
        self.profileHeader = header
        if section == 0 {
            return header
        } else {
            return nil
        }
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
