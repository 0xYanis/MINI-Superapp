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
    func fetch<T: Object>(_ objectType: T.Type) -> Results<T>?
}

final class RealmService: RealmServiceProtocol {
    
    typealias realmErr = RealmServiceError
    
    private lazy var realm = try! Realm(configuration: .defaultConfiguration)

    func add<T: Object>(_ object: T) throws {
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
    
    func fetch<T: Object>(_ objectType: T.Type) -> Results<T>? {
        let objects = realm.objects(objectType)
        return objects.count > 0 ? objects : nil
    }
    
    enum RealmServiceError: Error {
        case addObjectFailed(detail: String)
        case deleteObjectFailed(detail: String)
        case updateObjectFailed(detail: String)
        case fetchObjectFailed(detail: String)
    }
    
}

