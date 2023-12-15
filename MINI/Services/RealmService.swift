//
//  RealmService.swift
//  MINI
//
//  Created by Yan Rybkin on 23.06.2023.
//

import Foundation
import RealmSwift

protocol RealmServiceProtocol {
    func add<T: Object>(_ object: T) throws
    func read<T: Object>(_ objectType: T.Type, key: UUID) -> T?
    func delete<T: Object>(_ objectType: T.Type, forKey primaryKey: UUID) throws
    func update<T: Object>(_ object: T) throws
    func fetchAll<T: Object>(_ objectType: T.Type) throws -> [T]
    func deleteAll() throws
}

final class RealmService: RealmServiceProtocol {
    
    // MARK: - Private properties
    
    private var configuration: Realm.Configuration
    private lazy var realm = try? Realm(configuration: configuration)
    
    // MARK: - Lifecycle
    
    init(_ configuration: Realm.Configuration = .defaultConfiguration) {
        self.configuration = configuration
    }
    
    // MARK: - Methods
    
    func add<T: Object>(_ object: T) throws {
        guard let realm else { return }
        try realm.write {
            realm.add(object, update: .all)
        }
    }
    
    func read<T: Object>(_ objectType: T.Type, key: UUID) -> T? {
        guard let realm else { return nil }
        let object = realm.object(ofType: objectType, forPrimaryKey: key)
        return object
    }
    
    func delete<T: Object>(_ objectType: T.Type, forKey primaryKey: UUID) throws {
        guard let realm else { return }
        try realm.write {
            guard let object = realm.object(ofType: T.self, forPrimaryKey: primaryKey)
            else { return }
            realm.delete(object)
        }
    }
    
    func update<T: Object>(_ object: T) throws {
        guard let realm else { return }
        try realm.write {
            realm.add(object, update: .modified)
        }
    }
    
    func fetchAll<T: Object>(_ objectType: T.Type) throws -> [T] {
        guard let realm else { return [] }
        return realm.objects(T.self).asArray
    }
    
    func deleteAll() throws {
        guard let realm else { return }
        try realm.write {
            realm.deleteAll()
        }
    }
    
}

// MARK: - Results+Extension

extension Results {
    var asArray: [Element] {
        .init(self)
    }
}
