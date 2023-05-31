//
//  AllTemplatesInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import Foundation

protocol AllTemplatesInteractorProtocol: AnyObject {
    func getTemplatesData() -> [BankTemplateEntity]
    
    func userWillDeleteTemplate(id: Int)
}

final class AllTemplatesInteractor: AllTemplatesInteractorProtocol {
    weak var presenter: AllTemplatesPresenterProtocol?
    
    var tempaltesData: [BankTemplateEntity] = []
    
    init(templatesData: [BankTemplateEntity]) {
        self.tempaltesData = templatesData
    }
    
    func getTemplatesData() -> [BankTemplateEntity] {
        return tempaltesData
    }
    
    func userWillDeleteTemplate(id: Int) {
        ///
    }
}
