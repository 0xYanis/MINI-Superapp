//
//  RealmService.swift
//  MINI
//
//  Created by Yan Rybkin on 23.06.2023.
//

import RealmSwift

protocol RealmServiceProtocol {
    func add<T: Object>(_ object: T)
    func delete<T: Object>(_ object: T)
    func update<T: Object>(_ object: T)
    func fetch<T: Object>(_ objectType: T.Type) -> Results<T>?
}

final class RealmService: RealmServiceProtocol {
    
    private lazy var realm = try! Realm(configuration: .defaultConfiguration)

    func add<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func update<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func fetch<T: Object>(_ objectType: T.Type) -> Results<T>? {
        let objects = realm.objects(objectType)
        return objects.count > 0 ? objects : nil
    }
    
}

