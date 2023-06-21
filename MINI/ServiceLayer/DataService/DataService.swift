//
//  DataService.swift
//  MINI
//
//  Created by Yan Rybkin on 20.06.2023.
//

import Foundation

protocol DataServiceProtocol: AnyObject {
    func fetchObject<T>(objectName: String, id: Int) -> T?
    func fetchAllObjects<T>(objectName: String) -> [T]?
}

final class DataService: DataServiceProtocol {
    
    private lazy var database = StorageManager.shared
    
    func fetchObject<T>(objectName: String, id: Int) -> T? {
        database.fetchObject(objectName: objectName, id: Int16(id))
    }
    
    func fetchAllObjects<T>(objectName: String) -> [T]? {
        database.fetchAllObjects(objectName: objectName)
    }
    
}

