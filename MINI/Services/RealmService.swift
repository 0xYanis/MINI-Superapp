//
//  RealmService.swift
//  MINI
//
//  Created by Yan Rybkin on 23.06.2023.
//

import RealmSwift

protocol RealmServiceProtocol {
    func add<T: Object>(_ object: T) throws
    func delete<T: Object>(_ object: T) throws
    func update<T: Object>(_ object: T) throws
    func fetch<T: Object>(_ objectType: T.Type) throws -> [T]
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
    
    func fetch<T: Object>(_ objectType: T.Type) throws -> [T] {
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
