//
//  CartInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 05.09.2023.
//

import Foundation

protocol CartInteractorProtocol: AnyObject {
	
}

final class CartInteractor: CartInteractorProtocol {
	
	weak var presenter: CartPresenterProtocol?
	
}