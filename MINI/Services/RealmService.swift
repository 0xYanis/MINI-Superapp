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
    func delete<T: Object>(_ object: T) throws
    func deleteByKey<T: Object>(_ objectType: T.Type, forKey primaryKey: UUID) throws
    func update<T: Object>(_ object: T) throws
    func fetchAll<T: Object>(_ objectType: T.Type) throws -> [T]
    func deleteAll() throws
}

final class RealmService: RealmServiceProtocol {
    
    typealias realmErr = RealmServiceError
    
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
        do {
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            throw realmErr.addObjectFailed(
                detail: error.localizedDescription
            )
        }
    }
    
    func read<T: Object>(_ objectType: T.Type, key: UUID) -> T? {
        guard let realm else { return nil }
        let object = realm.object(ofType: objectType, forPrimaryKey: key)
        return object
    }
    
    func delete<T: Object>(_ object: T) throws {
        guard let realm else { return }
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            throw realmErr.deleteObjectFailed(
                detail: error.localizedDescription
            )
        }
    }
    
    func deleteByKey<T: Object>(_ objectType: T.Type, forKey primaryKey: UUID) throws {
        guard let realm else { return }
        do {
            try realm.write {
                guard let object = realm.object(ofType: T.self, forPrimaryKey: primaryKey)
                else { return }
                realm.delete(object)
            }
        } catch {
            throw realmErr.deleteObjectFailed(
                detail: error.localizedDescription
            )
        }
    }
    
    func update<T: Object>(_ object: T) throws {
        guard let realm else { return }
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            throw realmErr.updateObjectFailed(
                detail: error.localizedDescription
            )
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

// MARK: - RealmServiceError

extension RealmService {
    enum RealmServiceError: Error {
        case addObjectFailed(detail: String)
        case deleteObjectFailed(detail: String)
        case updateObjectFailed(detail: String)
        case fetchObjectFailed(detail: String)
    }
}

// MARK: - Results+Extension

extension Results {
    var asArray: [Element] {
        .init(self)
    }
}
