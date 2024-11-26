//
//  UserDetailsVM.swift
//  BaseCode
//
//  Created by orange on 27/03/24.
//

import Foundation
import CoreData
import UIKit

class UserDetailsVM {
    // MARK: - Save data
    func saveData(entityName: String, attributeData: [String : Any]) {
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let savedObject = try CoreDataOpertaionModel.shared.savingData(entityName, attributes: attributeData, context: context)
            print("Data saved successfully: \(savedObject)")
        } catch {
            print("Error saving data: \(error)")
        }
    }
    // MARK: - Fetch data
    func fetchData(entityName: String) -> [NSManagedObject] {
        var fetchedData : [NSManagedObject]?
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            fetchedData = try CoreDataOpertaionModel.shared.fetchingData(entityName, context: context)
            print("Fetched data: \(String(describing: fetchedData))")
        } catch {
            print("Error fetching data: \(error)")
        }
        return fetchedData ?? []
    }
    // MARK: - Update data
    func updateData(entityName: String, userId: Int, updatedName : String,updatedEmail: String, updatedEmpId: Int, updatedTech: String  ) {
        do {
            let predicate = NSPredicate(format: "empid == %d", userId)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            try CoreDataOpertaionModel.shared.updatingData(entityName, predicate: predicate, context: context) { employeData in
//                let name = updatedData[0].
                   // Perform updates on the employeData object
                   employeData.setValue(updatedName, forKey: "name")
                   employeData.setValue(updatedEmail, forKey: "email")
                   employeData.setValue(updatedEmpId, forKey: "empid")
                   employeData.setValue(updatedTech, forKey: "technology")
                   // Update other properties as needed
               }
            try context.save()
            print("Data updated successfully")
        } catch {
            print("Error updating data: \(error)")
        }
    }
    // MARK: - Delete data
    func deleteData(entityName: String, userId : Int) {
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            // Assuming entityName is the name of your entity
            let data = NSClassFromString(entityName) as? NSManagedObject.Type
            
            // Creating a predicate to match the empid
            let predicate = NSPredicate(format: "empid == %d", userId)
            
            // Delete objects based on the entity type and predicate
            try CoreDataOpertaionModel.shared.deleteData(entityType: data ?? NSManagedObject.self, predicate: predicate, context: context)
        } catch {
            print("Error deleting data: \(error.localizedDescription)")
        }
    }
    // MARK: - Delete all data
    func deleteAllData(entityName: String) {
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let data = NSClassFromString(entityName) as? NSManagedObject.Type
            
            try CoreDataOpertaionModel.shared.deleteAllData(data ?? NSManagedObject.self, context: context)
        } catch {
            print("Error deleting data: \(error.localizedDescription)")
        }
    }
}
