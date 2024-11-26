//
//  CoreDataOpertaionModel.swift
//  BaseCode
//
//  Created by orange on 27/03/24.
//

import Foundation
import CoreData

class CoreDataOpertaionModel {
    // Properties
    static let shared = CoreDataOpertaionModel()
    // default initialiser
    private init() {}
    // MARK: - Saving Data
    func savingData<T: NSManagedObject>(_ entityName: String, attributes: [String: Any], context: NSManagedObjectContext) throws -> T {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            throw NSError(domain: "CoreDataHelper", code: 500, userInfo: [NSLocalizedDescriptionKey: "Entity \(entityName) not found"])
        }
        let managedObject = T(entity: entityDescription, insertInto: context)
        // Set attributes
        for (key, value) in attributes {
            managedObject.setValue(value, forKey: key)
        }
        try context.save()
        return managedObject
    }
    // MARK: - Fetching Data
    func fetchingData<T: NSManagedObject>(_ entityName: String, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, context: NSManagedObjectContext) throws -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        return try context.fetch(fetchRequest)
    }
    // MARK: - Updating Data
    func updatingData<T: NSManagedObject>(_ entityName: String, predicate: NSPredicate? = nil, context: NSManagedObjectContext, updateBlock: @escaping (T) -> Void) throws {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
        let fetchedObjects = try context.fetch(fetchRequest)
        for object in fetchedObjects {
            updateBlock(object)
        }
        try context.save()
    }
    // MARK: - Deleting Data
    func deleteData<T: NSManagedObject>(entityType: T.Type, predicate: NSPredicate, context: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entityType))
        fetchRequest.predicate = predicate
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            for object in fetchedObjects {
                context.delete(object)
            }
            try context.save()
            print("Data deleted successfully.")
        } catch {
            print("Error deleting data: \(error.localizedDescription)")
        }
    }
    // MARK: - Deleting all Data
    func deleteAllData<T: NSManagedObject>(_ entityType: T.Type, context: NSManagedObjectContext) throws {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entityType))
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
            print("All data deleted successfully for entity: \(String(describing: entityType))")
        } catch {
            throw error
        }
    }
}
