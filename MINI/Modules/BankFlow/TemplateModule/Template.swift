//
//  BankTemplateEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation

struct Template: Identifiable, Codable {
    var id = UUID().uuidString
    var image: String
    var label: String
}

var mockTemplates: [Template] = [
    .init(image: "globe", label: "Mock Template"),
    .init(image: "globe", label: "Mock Template"),
    .init(image: "globe", label: "Mock Template"),
    .init(image: "globe", label: "Mock Template"),
    .init(image: "globe", label: "Mock Template"),
    .init(image: "globe", label: "Mock Template")
]
