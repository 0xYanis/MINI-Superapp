//
//  OrderPriceView.swift
//  MINI
//
//  Created by Yan Rybkin on 21.09.2023.
//

import UIKit
import SnapKit

final class OrderPriceView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

private extension OrderPriceView {
    
    func initialize() {
        backgroundColor = .clear
        createBlurEffect(blurStyle: .systemUltraThinMaterialDark)
    }
    
}
