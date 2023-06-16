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
        register(
            ProfileTableCell.self,
            forCellReuseIdentifier: ProfileTableCell.cellId
        )
    }
}

extension ProfileTableView: UITableViewDataSource {
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
        let defaultCell = UITableViewCell()
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileTableCell.cellId,
            for: indexPath
        ) as? ProfileTableCell else {
            return defaultCell
        }
        
        
        return cell
    }
}

extension ProfileTableView: UITableViewDelegate {
    
}
