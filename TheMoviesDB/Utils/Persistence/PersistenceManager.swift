//
//  PersistenceManager.swift
//  TheMoviesDB
//
//  Created by Lang Troyan on 02/11/2020.
//

import Foundation
import CoreData

class PersistenceManager {
    static func save() {
        CoreDataStack.shared.saveContext()
    }
    
    static func fetch<T: NSManagedObject>(from entity: String) -> [T]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.returnsObjectsAsFaults = false
        do {
            let result = try CoreDataStack.shared.persistentContainer.viewContext.fetch(request) as? [T]
            return result
        } catch {
            print("Fetching data Failed")
        }
        return nil
    }
    
    static func delete(named entity: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try CoreDataStack.shared.persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
}
