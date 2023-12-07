//
//  TemplateRepository.swift
//  MINI
//
//  Created by Yanis on 03.12.2023.
//

import Foundation

protocol TemplateRepositoryProtocol: AnyObject {
    func addTemplate(_ template: Template) throws
    func readTemplate(primaryKey: UUID) -> Template?
    func deleteTemplate(key: UUID) throws
    func updateTemplate(_ template: Template) throws
    func fetchTemplates() throws -> [Template]
}

final class TemplateRepository: TemplateRepositoryProtocol {
    
    private let storage: RealmServiceProtocol
    
    init() {
        self.storage = RealmService()
    }
    
    func addTemplate(_ template: Template) throws {
        let object = TemplateObject(template)
        try storage.add(object)
    }
    
    func readTemplate(primaryKey: UUID) -> Template? {
        guard let object = storage.read(TemplateObject.self, key: primaryKey)
        else { return nil }
        return Template(object)
    }
    
    func deleteTemplate(key: UUID) throws {
        try storage.delete(TemplateObject.self, forKey: key)
    }
    
    func updateTemplate(_ template: Template) throws {
        let object = TemplateObject(template)
        try storage.update(object)
    }
    
    func fetchTemplates() throws -> [Template] {
        let objects = try storage.fetchAll(TemplateObject.self)
        return objects.compactMap { Template($0) }
    }
    
}
