//
//  BankSection.swift
//  MINI
//
//  Created by Yanis on 02.10.2023.
//

import Foundation

enum BankSection {
    case card([BankCardEntity])
    case templateLabel
    case template([BankTemplateEntity])
    
    public var title: String {
        switch self {
        case .card(_):       return ""
        case .templateLabel: return "Шаблоны"
        case .template(_):   return ""
        }
    }
    
    public var count: Int {
        switch self {
        case .card(let cards):         return cards.count
        case .templateLabel:           return 1
        case .template(let templates): return templates.count
        }
    }
    
}
