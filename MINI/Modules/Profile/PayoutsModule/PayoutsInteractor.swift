//
//  PayoutsInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 18.08.2023.
//

import Foundation

protocol PayoutsInteractorProtocol: AnyObject {
    func getData() -> [PayoutsModel]
}

final class PayoutsInteractor: PayoutsInteractorProtocol {
    
    weak var presenter: PayoutsPresenterProtocol?
    
    private var payoutsData: [PayoutsModel] = []
    
    func getData() -> [PayoutsModel] {
        return payoutsData
    }
    
}
