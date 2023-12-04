//
//  Double+Extension.swift
//  MINI
//
//  Created by Yanis on 03.12.2023.
//

import Foundation

extension Double {
    
    var toCurrency: String {
        return currencyFormatter.string(for: self) ?? ""
    }
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
}
