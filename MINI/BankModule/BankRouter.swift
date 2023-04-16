//
//  BankRouter.swift
//  MINI
//
//  Created by Yan Rybkin on 16.04.2023.
//

import Foundation

protocol BankRouterProtocol: AnyObject {
    
}

final class BankRouter: BankRouterProtocol {
    weak var view: BankViewController?
    
}
