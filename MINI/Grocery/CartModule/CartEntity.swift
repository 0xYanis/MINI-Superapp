//
//  CartEntity.swift
//  MINI
//
//  Created by Yan Rybkin on 03.07.2023.
//

import RealmSwift

struct CartEntity: Codable {
    var cartList: [CartEntityObject]
}

@objcMembers
final class CartEntityObject: Object, Codable {
    dynamic var name: String = ""
    dynamic var text: String = ""
    dynamic var price: String = ""
}
