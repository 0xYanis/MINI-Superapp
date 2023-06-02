//
//  AviaService.swift
//  MINI
//
//  Created by Yan Rybkin on 30.05.2023.
//

import Foundation

protocol AviaShowplaceServiceProtocol: AnyObject {
    func getShowplaceData(completion: @escaping(Result<[BankCardModel]?, Error>) -> Void)
}

final class AviaShowplaceService: AviaShowplaceServiceProtocol {
    
    var apiService: APIServiceProtocol
    private let url = "https://opentripmap.io/"
    private let api = "5ae2e3f221c38a28845f05b6accc24f8b1d5302e58c48ae1a0cc5eff"
    
    init(
        apiService: APIServiceProtocol = APIService()
    ) {
        self.apiService = apiService
    }
    
    func getShowplaceData(completion: @escaping (Result<[BankCardModel]?, Error>) -> Void) {
        
    }
    
    
}
