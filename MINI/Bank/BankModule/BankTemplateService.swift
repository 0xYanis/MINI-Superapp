//
//  BankTemplateService.swift
//  MINI
//
//  Created by Yan Rybkin on 15.05.2023.
//

import Foundation

protocol BankTemplateServiceProtocol: AnyObject {
    func getTemplatesData(completion: @escaping(Result<[BankTemplateEntity]?, Error>) -> Void)
}

final class BankTemplateService: BankTemplateServiceProtocol {
    
    var apiService: APIServiceProtocol
    private let cardUrl = "https://my-json-server.typicode.com/0xyanis/MINIapi/templates"
    private let cache = NSCache<NSString, BankTemplateObject>()
    
    init(
        apiService: APIServiceProtocol
    ) {
        self.apiService = apiService
    }
    
    func getTemplatesData(completion: @escaping(Result<[BankTemplateEntity]?, Error>) -> Void) {
        if let cacheData = cache.object(forKey: "BankTemplateObject") {
            completion(.success(cacheData.templateList))
        } else {
            apiService.getRequest(url: cardUrl) { (result: Result<BankTemplateObject, Error>) in
                switch result {
                case .success(let data):
                    self.cache.setObject(data, forKey: "BankTemplateObject")
                    completion(.success(data.templateList))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    
}
