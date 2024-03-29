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
    
    var isOnlyLetters: Bool {
        allSatisfy { $0.isLetter }
    }
    
    var isOnlyNumbers: Bool {
        allSatisfy { $0.isNumber }
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
    
    func getEmailName() -> String? {
        let components = self.components(separatedBy: "@")
        return components.first
    }
    
    func pluralize(count: Int) -> String {
        if count % 10 == 1 && count % 100 != 11 {
            return self
        } else if count % 10 >= 2 && count % 10 <= 4 && (count % 100 < 10 || count % 100 >= 20) {
            return self + "а"
        } else {
            return self + "ов"
        }
    }
    
    
}
