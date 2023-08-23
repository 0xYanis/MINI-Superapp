//
//  Date+Extension.swift
//  MINI
//
//  Created by Yan Rybkin on 23.08.2023.
//

import Foundation

extension Date {
    func currentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
