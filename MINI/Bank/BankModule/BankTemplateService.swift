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
    
    func getTemplatesData(completion: @escaping(Result<[BankTemplateEntity]?, Error>) -> Void) {
        
    }
    
    
}
