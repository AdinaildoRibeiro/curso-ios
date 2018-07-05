//
//  CoreDataUtil.swift
//  Contatos
//
//  Created by ios7649 on 05/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import Foundation
import CoreData


class CoreDataUtil {
    
    static let shared = CoreDataUtil()
    
    private init(){
        
    }
    
    func newManaged(name: String) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: name, into: persistentContainer.viewContext)
    }
    
    func findAll() -> [Contato]{
        let request = NSFetchRequest<Contato>(entityName: "Contato")
        
        do {
            return try persistentContainer.viewContext.fetch(request)
        }catch let erro as NSError {
            fatalError("Error fetch date \(erro), \(erro.userInfo)")
            
        }
    }
    
    func remove(managedObject: Contato) {
        persistentContainer.viewContext.delete(managedObject)
    }
    
    // *************************************************************************** //
    
    // Metodos de persistencia movidos do AppDelegate para esta classe
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Contatos")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func commit () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
