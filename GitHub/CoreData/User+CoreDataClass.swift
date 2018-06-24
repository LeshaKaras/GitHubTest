//
//  User+CoreDataClass.swift
//  GitHub
//
//  Created by Alexei Karas on 24.06.2018.
//  Copyright © 2018 TestOrg. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {

    convenience init() {
        self.init(entity: DataManager.accessManager.entityForName(entityName:"User"), insertInto: DataManager.accessManager.persistentContainer.viewContext)
    }
    convenience init(nick:String, password:String) {
        self.init()
        self.nickUser = nick
        self.passwordUser = password
    }
    
}
