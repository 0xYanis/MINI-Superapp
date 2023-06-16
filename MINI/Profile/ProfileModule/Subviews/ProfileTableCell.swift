//
//  ProfileTableCell.swift
//  MINI
//
//  Created by Yan Rybkin on 16.06.2023.
//

import UIKit
import SnapKit

final class ProfileTableCell: UITableViewCell {
    
    static let cellId = "ProfileTableCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfileTableCell {
    func initialize() {
        
    }
}
