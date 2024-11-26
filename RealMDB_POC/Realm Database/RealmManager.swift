//
//  RealmManager.swift
//  BaseCode
//
//  Created by orange on 30/04/24.
//

import Foundation
import RealmSwift

class RealmManager<T: Object> {
    private var realm: Realm
    init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to create Realm instance: \(error)")
        }
    }
    // MARK: - CRUD Operations
    func create(object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            fatalError("Failed to save object: \(error)")
        }
    }
    // Function for fetching the full data
    func retrieveAll() -> Results<T> {
        return realm.objects(T.self)
    }
    // Function for fetching the particular data using Predicate
    func retrieve(with predicate: NSPredicate) -> Results<T> {
        return realm.objects(T.self).filter(predicate)
    }
    // Function for updating the Properties of particular object
    func update(object: T, with properties: [String: Any]) {
        do {
            try realm.write {
                for (key, value) in properties {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            fatalError("Failed to update object: \(error)")
        }
    }
    // Function for Delating the Particular object from the Database
    func delete(object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            fatalError("Failed to delete object: \(error)")
        }
    }
    // Function for Deleting the all the object from the Database
    func deleteAll() {
        do {
            try realm.write {
                realm.delete(realm.objects(T.self))
            }
        } catch {
            fatalError("Failed to delete all objects: \(error)")
        }
    }
}
