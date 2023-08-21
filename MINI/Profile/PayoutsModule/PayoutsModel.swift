//
//  PayoutsModel.swift
//  MINI
//
//  Created by Yan Rybkin on 21.08.2023.
//

import Foundation
import UIKit

struct PayoutsModel {
    var type: PayoutsType
    var image: UIImage
    var title: String
    var description: String
}

enum PayoutsType {
    case favorites
    case tickets
    case orders
    case transactions
}
