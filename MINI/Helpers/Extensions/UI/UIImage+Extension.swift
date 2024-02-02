//
//  UIImage+Extension.swift
//  MINI
//
//  Created by Yanis on 11.10.2023.
//

import UIKit

extension UIImage {
    
    convenience init?(_ system: SystemSymbol) {
        self.init(systemName: system.rawValue)
    }
    
    enum SystemSymbol: String {
        case basketFill = "basket.fill"
        case airplane
        case houseFill = "house.fill"
        case calendar
        case globe
        case creditcard
        case plus
        case gear
        case trash
        case magnifyingglass
        case magnifyingglassCircle = "magnifyingglass.circle"
        case magnifyingglassCircleFill = "magnifyingglass.circle.fill"
        case chevronRigthCircle = "chevron.right.circle"
        case person
        case personFill = "person.fill"
        case lockCircle = "lock.circle"
        case creditcardFill = "creditcard.fill"
        case plusRectangleFill = "plus.rectangle.fill"
        case sqaureAndPencil = "square.and.pencil"
        case circleFill = "circle.fill"
        case noteText = "note.text"
        case plusMinus = "plus.minus"
        case bookmark
        case squareAndArrowUp = "square.and.arrow.up"
        case percent
        case cartFill = "cart.fill"
        case mappinAndEllipse = "mappin.and.ellipse"
        case map
        case arrowUp = "arrow.up"
    }
    
}
