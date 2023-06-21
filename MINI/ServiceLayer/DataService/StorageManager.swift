//
//  StorageManager.swift
//  MINI
//
//  Created by Yan Rybkin on 21.06.2023.
//

import CoreData

public final class StorageManager {
    public static var shared = StorageManager()
    
    private init() {}
    
    private lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "")
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error {
                fatalError(error.localizedDescription)
            }
        })
        return container
    }()
}

//MARK: - methods
public extension StorageManager {
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func fetchObject<T>(objectName: String, id: Int16) -> T? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: objectName)
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            let data = try? context.fetch(request) as? [T]
            return data?.first
        }
    }
    
    func fetchAllObjects<T>(objectName: String) -> [T]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: objectName)
        do {
            let data = try? context.fetch(request) as? [T]
            return data
        }
    }
}
