//
//  RealmService.swift
//  MINI
//
//  Created by Yan Rybkin on 23.06.2023.
//

import Foundation
import RealmSwift

public protocol RealmServiceProtocol {
    func add<T: Object>(_ object: T) throws
    func read<T: Object>(_ objectType: T.Type, key: UUID) -> T?
    func delete<T: Object>(_ objectType: T.Type, forKey primaryKey: UUID) throws
    func update<T: Object>(_ object: T) throws
    func fetchAll<T: Object>(_ objectType: T.Type) throws -> [T]
    func deleteAll() throws
}

public final class RealmService: RealmServiceProtocol {
    
    // MARK: - Private properties
    
    private var configuration: Realm.Configuration
    private lazy var realm = try? Realm(configuration: configuration)
    
    // MARK: - Lifecycle
    
    public init(_ configuration: Realm.Configuration = .defaultConfiguration) {
        self.configuration = configuration
    }
    
    // MARK: - Methods
    
    public func add<T: Object>(_ object: T) throws {
        guard let realm else { return }
        try realm.write {
            realm.add(object, update: .all)
        }
    }
    
    public func read<T: Object>(_ objectType: T.Type, key: UUID) -> T? {
        guard let realm else { return nil }
        let object = realm.object(ofType: objectType, forPrimaryKey: key)
        return object
    }
    
    public func delete<T: Object>(_ objectType: T.Type, forKey primaryKey: UUID) throws {
        guard let realm else { return }
        try realm.write {
            guard let object = realm.object(ofType: T.self, forPrimaryKey: primaryKey)
            else { return }
            realm.delete(object)
        }
    }
    
    public func update<T: Object>(_ object: T) throws {
        guard let realm else { return }
        try realm.write {
            realm.add(object, update: .modified)
        }
    }
    
    public func fetchAll<T: Object>(_ objectType: T.Type) throws -> [T] {
        guard let realm else { return [] }
        return realm.objects(T.self).asArray
    }
    
    public func deleteAll() throws {
        guard let realm else { return }
        try realm.write {
            realm.deleteAll()
        }
    }
}

// MARK: - Results+Extension

public extension Results {
    var asArray: [Element] { return Results(self) }
}
