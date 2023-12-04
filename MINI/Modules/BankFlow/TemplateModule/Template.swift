//
//  BankTemplateEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation
import RealmSwift

struct Template: Identifiable, Codable {
    var id: UUID
    var image: String
    var label: String
    
    static var examples: [Template] {
        return [
            Template(id: .init(), image: "creditcard", label: "Credit Card"),
            Template(id: .init(), image: "banknote", label: "Bank Transfer"),
            Template(id: .init(), image: "dollarsign.circle", label: "PayPal"),
            Template(id: .init(), image: "bitcoinsign.circle", label: "Bitcoin"),
            Template(id: .init(), image: "person.2", label: "Person-to-Person"),
            Template(id: .init(), image: "square.grid.3x3.topleft.fill", label: "Other")
        ]
    }
}

extension Template {
    init(_ object: TemplateObject) {
        id = object.id
        image = object.image
        label = object.label
    }
}

class TemplateObject: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var image: String
    @Persisted var label: String
}

extension TemplateObject {
    convenience init(_ dto: Template) {
        self.init()
        id = dto.id
        image = dto.image
        label = dto.label
    }
}
