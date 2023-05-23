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

final class RealmService {
    
}
