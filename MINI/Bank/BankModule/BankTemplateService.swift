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
            BankTemplateEntity(image: "phone.fill", label: "Phone number"),
            BankTemplateEntity(image: "fork.knife", label: "Sunday BBQ"),
            BankTemplateEntity(image: "4k.tv.fill", label: "Netflix"),
            BankTemplateEntity(image: "carrot", label: "Amazon Plus"),
            BankTemplateEntity(image: "photo.tv", label: "HBO Max"),
            BankTemplateEntity(image: "y.square", label: "Yandex: Kinopoisk")
        ]
        
        completion(.success(templateData))
    }
    
    
}
