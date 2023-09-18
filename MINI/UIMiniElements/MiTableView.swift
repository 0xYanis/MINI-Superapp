//
//  MiTableView.swift
//  MINI
//
//  Created by Yan Rybkin on 08.08.2023.
//

import UIKit

class MiTableView: UITableView {
    
    override init(frame: CGRect = .zero, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func register<C: UITableViewCell>(_ cell: C.Type) {
        register(cell, forCellReuseIdentifier: String(describing: cell))
    }
    
    func addCell<C: UITableViewCell>(_ cell: C.Type, indexPath: IndexPath) -> C {
        guard
            let cell = dequeueReusableCell(
                withIdentifier: String(describing: cell),
                for: indexPath) as? C
        else { fatalError() }
        return cell
    }
    
}
