//
//  CardRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 24.04.2023.
//

import Foundation

protocol CardRouterProtocol: AnyObject {
    
}

final class CardRouter: CardRouterProtocol {
    weak var view: CardViewController?
}
