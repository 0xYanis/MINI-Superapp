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
    
    weak var profileHeader: ProfileHeader?
    
    private var multiplier: CGFloat = 0
    
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
        section == 0 ? 130 : tableView.sectionHeaderHeight
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.y + 149
        // 149 - привидение к нулю
        self.multiplier = 1 - (value / 261)
        // 261 - макс. значение
        if value > 0 {
            profileHeader?.updateScale(multiplier)
            profileHeader?.layer.opacity = Float(multiplier)
        }
    }
    
}
