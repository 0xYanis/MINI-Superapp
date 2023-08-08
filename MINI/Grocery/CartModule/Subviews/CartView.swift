//
//  CartView.swift
//  MINI
//
//  Created by Yan Rybkin on 03.07.2023.
//

import UIKit
import SnapKit

final class CartView: UIView {
    
    weak var delegate: CartViewDelegate?
    
    private lazy var tableView  = MiTableView()
    private lazy var totalView  = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func safeAreaInsetsDidChange() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(safeAreaInsets.top)
            make.left.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        totalView.snp.makeConstraints { make in
            make.height.equalTo(180)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}

private extension CartView {
    func initialize() {
        backgroundColor = .clear
        createTableView()
        createTotalView()
    }
    
    func createTableView() {
        tableView.backgroundColor = .green
        insertSubview(tableView, at: 0)
    }
    
    func createTotalView() {
        totalView.backgroundColor = .red
        insertSubview(totalView, at: 1)
    }
    
}
