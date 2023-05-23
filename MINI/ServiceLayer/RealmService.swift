//
//  RealmService.swift
//  MINI
//
//  Created by Yan Rybkin on 23.05.2023.
//
import Foundation
import RealmSwift

protocol RealmServiceProtocol: AnyObject {
    func add(object: Object)
    func update(object: Object, with dictionary: [String: Any?])
    func delete(object: Object)
    func deleteAll<T: Object>(_ objectType: T.Type)
    func fetch<T: Object>(_ objectType: T.Type, predicate: NSPredicate?, sortedByKeyPath keyPath: String?, ascending: Bool) -> Results<T>
}

final class RealmService: RealmServiceProtocol {
    
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func add(object: Object) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error adding object to Realm: \(error.localizedDescription)")
        }
    }
    
    func update(object: Object, with dictionary: [String: Any?]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            print("Error updating object in Realm: \(error.localizedDescription)")
        }
    }
    
    func delete(object: Object) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error deleting object from Realm: \(error.localizedDescription)")
        }
    }
    
    func deleteAll<T: Object>(_ objectType: T.Type) {
        do {
            try realm.write {
                let objects = realm.objects(objectType)
                realm.delete(objects)
            }
        } catch {
            print("Error deleting all objects from Realm: \(error.localizedDescription)")
        }
    }
    
    func fetch<T: Object>(_ objectType: T.Type, predicate: NSPredicate? = nil, sortedByKeyPath keyPath: String? = nil, ascending: Bool = true) -> Results<T> {
        var results = realm.objects(objectType)
        if let predicate = predicate {
            results = results.filter(predicate)
        }
        if let keyPath = keyPath {
            results = results.sorted(byKeyPath: keyPath, ascending: ascending)
        }
        return results
    }
}

