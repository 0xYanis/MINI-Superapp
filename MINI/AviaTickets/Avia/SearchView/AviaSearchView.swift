//
//  AviaSearchView.swift
//  MINI
//
//  Created by Yan Rybkin on 03.05.2023.
//

import UIKit

final class AviaSearchView: UIView {
    
    private let flyFromTextField = UITextField()
    private let flyToTextField = UITextField()
    private let datePicker = UIDatePicker()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

private extension AviaSearchView {
    func initialize() {
        backgroundColor = .green
    }
}
