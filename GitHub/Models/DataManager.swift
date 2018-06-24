//
//  DataManager.swift
//  GitHub
//
//  Created by Alexei Karas on 24.06.2018.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {

    static let accessManager = DataManager()

    
    //MARK: Create objects
    func createLogInUser(nick:String, password:String) {
        
        let user = executeFetchRequestUserInArray().first
        user?.nickUser = nick
        user?.passwordUser = password
        DataManager.accessManager.saveContext()
    }
    
    //MARK: execute
    func executeFetchRequestUserInArray() -> [User] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let array = try DataManager.accessManager.persistentContainer.viewContext.fetch(fetchRequest) as! [User]
            
            if (array.count == 0){
                let newUser = User()
                saveContext()
                return[newUser]
            }
            
            return array
        } catch {
            return []
        }
        
    }
    
    //MARK: Tools
    func entityForName(entityName:String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: self.persistentContainer.viewContext)!
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
 
        let container = NSPersistentContainer(name: "GitHub")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
