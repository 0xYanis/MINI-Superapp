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
        let templateData = [
            BankTemplateEntity(id: 0, image: "phone.fill", label: "Phone number"),
            BankTemplateEntity(id: 1, image: "fork.knife", label: "Sunday BBQ"),
            BankTemplateEntity(id: 2, image: "4k.tv.fill", label: "Netflix"),
            BankTemplateEntity(id: 3, image: "carrot", label: "Amazon Plus"),
            BankTemplateEntity(id: 4, image: "photo.tv", label: "HBO Max"),
            BankTemplateEntity(id: 5, image: "y.square", label: "Yandex: Kinopoisk")
        ]
        
        completion(.success(templateData))
    }
    
    
}
