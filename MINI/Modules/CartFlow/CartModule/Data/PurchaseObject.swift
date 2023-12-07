//
//  PurchaseObject.swift
//  MINI
//
//  Created by Yanis on 07.12.2023.
//

import Foundation
import RealmSwift

class PurchaseObject: Object {
    @Persisted var id: UUID
    @Persisted var name: String
    @Persisted var image: String = "AppIcon"
    @Persisted var type: PurchaseType
    @Persisted var descriptionObj: String
    @Persisted var quantity: Int
    @Persisted var price: Double
}

extension PurchaseObject {
    convenience init(_ dto: Purchase) {
        self.init()
        self.id = dto.id
        self.name = dto.name
        self.type = dto.type
        self.descriptionObj = dto.description
        self.quantity = dto.quantity
        self.price = dto.price
    }
}
