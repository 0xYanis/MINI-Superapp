//
//  String+Extension.swift
//  MINI
//
//  Created by Yan Rybkin on 24.05.2023.
//

import Foundation

extension String {
    
    var localized: String {
        NSLocalizedString(
            self,
            comment: "\(self) could not be found in Localizable.strings"
        )
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    func formattedDateString(dateFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "date_formatter_id".localized)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else { return nil }
        
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
    
    func getCurrencySymbol() -> String {
        switch self {
        case "USD":
            return "$"
        case "EUR":
            return "€"
        case "GBP":
            return "£"
        case "RUB":
            return "₽"
        default:
            return ""
        }
    }
    
    func formatAsCardNumber() -> String {
        var formatted = ""
        for (index, char) in self.enumerated() {
            if index != 0 && index % 4 == 0 {
                formatted.append(" ")
            }
            formatted.append(char)
        }
        return formatted
    }
}
