//
//  AllTemplatesInteractor.swift
//  MINI
//
//  Created by Yan Rybkin on 27.04.2023.
//

import Foundation

protocol AllTemplatesInteractorProtocol: AnyObject {
    var tempaltes: [Template] { get }
    
    func deleteTemplate(id: Int)
    func moveTemplate(from: Int, to: Int)
    func fetchTemplates()
}

final class AllTemplatesInteractor: AllTemplatesInteractorProtocol {
    weak var presenter: AllTemplatesPresenterProtocol?
    
    var tempaltes = [Template]()
    
    private var repository: TemplateRepositoryProtocol
    
    init(tempaltes: [Template]) {
        self.tempaltes = tempaltes
        self.repository = TemplateRepository()
    }
    
    func deleteTemplate(id: Int) {
        let current = tempaltes.remove(at: id)
        try? repository.deleteTemplateBy(key: current.id)
    }
    
    func moveTemplate(from: Int, to: Int) {
        tempaltes.swapAt(from, to)
    }
    
    func fetchTemplates() {
        guard let templates = try? repository.fetchTemplates()
        else { return }
        templates.forEach { self.tempaltes.append($0) }
        
        presenter?.updateView()
    }
    
}
