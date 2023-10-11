//
//  Transfer.swift
//  MINI
//
//  Created by Yanis on 10.10.2023.
//

import Foundation

struct Transfer: Identifiable, Codable {
    var id = UUID().uuidString
    var image: String?
    var name: String
    var text: String?
}

var mockTransfers: [Transfer] = [
    .init(image: nil, name: "Yani", text: "iOS Developer"),
    .init(image: nil, name: "Yani", text: "iOS Developer"),
    .init(image: nil, name: "Yani", text: "iOS Developer"),
    .init(image: nil, name: "Yani", text: "iOS Developer"),
    .init(image: nil, name: "Yani", text: "iOS Developer"),
    .init(image: nil, name: "Yani", text: "iOS Developer")
]
