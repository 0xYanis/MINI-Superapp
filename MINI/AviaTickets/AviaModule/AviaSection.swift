//
//  AviaSection.swift
//  MINI
//
//  Created by Yan Rybkin on 11.09.2023.
//

import Foundation

enum AviaSection {
    case hotDeals([AviaItem])
    case places([AviaItem])
    case cities([AviaItem])
    case countries([AviaItem])
    
    var title: String {
        switch self {
        case .hotDeals(_):
            return ""
        case .places(_):
            return ""
        case .cities(_):
            return ""
        case .countries(_):
            return ""
        }
    }
    
    var items: [AviaItem] {
        switch self {
        case .hotDeals(let items):  return items
        case .places(let items):    return items
        case .cities(let items):    return items
        case .countries(let items): return items
        }
    }
    
    var count: Int {
        return items.count
    }
    
}
