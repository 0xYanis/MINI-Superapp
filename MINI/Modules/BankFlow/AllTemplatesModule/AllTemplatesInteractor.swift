//
//  AllTemplatesInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import Foundation

protocol AllTemplatesInteractorProtocol: AnyObject {
    var tempaltesData: [Template] { get }
    func userWillDeleteTemplate(id: Int)
    func userWillMoveTemplate(from: Int, to: Int)
}

final class AllTemplatesInteractor: AllTemplatesInteractorProtocol {
    weak var presenter: AllTemplatesPresenterProtocol?
    
    var tempaltesData: [Template] = []
    
    init(templatesData: [Template]) {
        self.tempaltesData = templatesData
    }
    
    func userWillDeleteTemplate(id: Int) {
        tempaltesData.remove(at: id)
    }
    
    func userWillMoveTemplate(from: Int, to: Int) {
        tempaltesData.swapAt(from, to)
    }
    
}
