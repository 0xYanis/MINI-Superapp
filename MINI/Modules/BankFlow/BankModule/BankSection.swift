//
//  BankSection.swift
//  MINI
//
//  Created by Yanis on 02.10.2023.
//

import Foundation

enum BankSection {
    case card([Card])
    case template([Template])
    
    public var title: String {
        switch self {
        case .card(_)    : return ""
        case .template(_): return ""
        }
    }
    
    public var count: Int {
        switch self {
        case .card(let cards):         return cards.count
        case .template(let templates): return templates.count
        }
    }
    
}
