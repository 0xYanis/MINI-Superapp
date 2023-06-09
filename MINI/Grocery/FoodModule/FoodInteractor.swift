//
//  FoodInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 09.06.2023.
//

import Foundation

protocol FoodInteractorProtocol: AnyObject {
    
}

final class FoodInteractor: FoodInteractorProtocol {
    
    weak var presenter: FoodPresenterProtocol?
    
    
}
