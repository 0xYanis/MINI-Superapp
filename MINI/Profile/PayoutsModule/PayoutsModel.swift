//
//  PayoutsModel.swift
//  MINI
//
//  Created by Yan Rybkin on 21.08.2023.
//

import Foundation

struct PayoutsModel {
    var image: String
    var title: String
    var description: String
}

enum PayoutsType {
    case favorites
    case tickets
    case orders
    case transactions
}
