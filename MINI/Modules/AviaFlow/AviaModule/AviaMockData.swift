//
//  AviaMockData.swift
//  MINI
//
//  Created by Yan Rybkin on 11.09.2023.
//

import Foundation

struct AviaMockData {
    
    static let shared = AviaMockData()
    
    private init() {}
    
    var sections: [AviaSection] {
        [hotDeals, places, cities, countries]
    }
    
    private let hotDeals: AviaSection = {
        return .hotDeals(Array(repeating: AviaItem(title: "", description: "", imageUrl: "", location: "", price: 0.0), count: 5))
    }()
    
    private let places: AviaSection = {
        return .places(Array(repeating: AviaItem(title: "", description: "", imageUrl: "", location: "", price: 0.0), count: 15))
    }()
    
    private let cities: AviaSection = {
        return .cities(Array(repeating: AviaItem(title: "", description: "", imageUrl: "", location: "", price: 0.0), count: 5))
    }()
    
    
    private let countries: AviaSection = {
        return .countries(Array(repeating: AviaItem(title: "", description: "", imageUrl: "", location: "", price: 0.0), count: 20))
    }()
    
    
}
