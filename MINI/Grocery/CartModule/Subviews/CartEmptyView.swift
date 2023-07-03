//
//  CartEmptyView.swift
//  MINI
//
//  Created by Yan Rybkin on 03.07.2023.
//

import UIKit
import SnapKit

final class CartEmptyView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
}

private extension CartEmptyView {
    func initialize() {
        backgroundColor = .red
    }
}
