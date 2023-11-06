//
//  Array+Extension.swift
//  MINI
//
//  Created by Yanis on 06.11.2023.
//

import Foundation

extension Array where Element: Comparable {
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
}
