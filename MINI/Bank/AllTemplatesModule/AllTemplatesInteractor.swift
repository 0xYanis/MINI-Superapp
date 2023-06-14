//
//  AllTemplatesInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import Foundation

protocol AllTemplatesInteractorProtocol: AnyObject {
    var tempaltesData: [BankTemplateEntity] { get }
    func userWillDeleteTemplate(id: Int)
    func userWillMoveTemplate(from: Int, to: Int)
}

final class AllTemplatesInteractor: AllTemplatesInteractorProtocol {
    weak var presenter: AllTemplatesPresenterProtocol?
    
    var tempaltesData: [BankTemplateEntity] = []
    
    init(templatesData: [BankTemplateEntity]) {
        self.tempaltesData = templatesData
    }
    
    func userWillDeleteTemplate(id: Int) {
        tempaltesData.remove(at: id)
    }
    
    func userWillMoveTemplate(from: Int, to: Int) {
        tempaltesData.swapAt(from, to)
    }
}
