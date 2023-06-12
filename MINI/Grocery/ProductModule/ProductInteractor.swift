//
//  ProductInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 12.06.2023.
//

import Foundation

protocol ProductInteractorProtocol: AnyObject {
    
}

final class ProductInteractor: ProductInteractorProtocol {
    
    weak var presenter: ProductPresenterProtocol?
    
}
