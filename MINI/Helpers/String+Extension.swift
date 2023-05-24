//
//  String+Extension.swift
//  MINI
//
//  Created by Yan Rybkin on 24.05.2023.
//

import Foundation

extension String {
    func formattedDateString(dateFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else { return nil }
        
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
}
