//
//  AviaInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 03.05.2023.
//

import Foundation

protocol AviaInteractorProtocol: AnyObject {
    
}

final class AviaInteractor: AviaInteractorProtocol {
    
    weak var presenter: AviaPresenterProtocol?
    var aivaShowplaceService: AviaShowplaceServiceProtocol
    
    init(
        aivaShowplaceService: AviaShowplaceServiceProtocol
    ) {
        self.aivaShowplaceService = aivaShowplaceService
    }
    
    
    
}

private extension AviaInteractor {
    
}
