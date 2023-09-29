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
        return .hotDeals([
            .init(title: "Turkey", description: "Try the best kebab in the country!", imageUrl: "", location: "Stambul", price: 138.99),
            .init(title: "Armenia", description: "The most beautiful temples.", imageUrl: "", location: "Yerevan", price: 95.59),
            .init(title: "China", description: "Country from the future!", imageUrl: "", location: "Pekin", price: 32.49),
            .init(title: "India", description: "The extraordinary beauty of the ancient state.", imageUrl: "", location: "New-Deli", price: 129.60)
        ])
    }()
    
    private let places: AviaSection = {
        return .places([
            .init(title: "Saint-Petersburg", imageUrl: "", location: "Russia", price: 9.98),
            .init(title: "Kaliningrad", imageUrl: "", location: "Russia", price: 39.5),
            .init(title: "Moscow", imageUrl: "", location: "Russia", price: 22.10),
            .init(title: "Voronej", imageUrl: "", location: "Russia", price: 29.99)
        ])
    }()
    
    private let cities: AviaSection = {
        return .cities([
            .init(title: "Moscow", imageUrl: "moscow.jpg", location: "Russia"),
            .init(title: "New York", imageUrl: "new_york.jpg", location: "United States"),
            .init(title: "Paris", imageUrl: "paris.jpg", location: "France"),
            .init(title: "Tokyo", imageUrl: "tokyo.jpg", location: "Japan"),
            .init(title: "London", imageUrl: "london.jpg", location: "United Kingdom"),
            .init(title: "Dubai", imageUrl: "dubai.jpg", location: "United Arab Emirates"),
            .init(title: "Rome", imageUrl: "rome.jpg", location: "Italy"),
            .init(title: "Sydney", imageUrl: "sydney.jpg", location: "Australia")
        ])
    }()
    
    
    private let countries: AviaSection = {
        return .countries([
            .init(title: "United States", imageUrl: "us.jpg", location: "North America"),
            .init(title: "Germany", imageUrl: "germany.jpg", location: "Europe"),
            .init(title: "China", imageUrl: "china.jpg", location: "Asia"),
            .init(title: "Brazil", imageUrl: "brazil.jpg", location: "South America"),
            .init(title: "South Africa", imageUrl: "south_africa.jpg", location: "Africa"),
            .init(title: "Australia", imageUrl: "australia.jpg", location: "Australia")
        ])
    }()
    
    
}
