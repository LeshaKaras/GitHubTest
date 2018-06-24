//
//  CreateObjectsManager.swift
//  GitHub
//
//  Created by Alexei Karas on 24.06.2018.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import UIKit

class CreateObjectsManager: NSObject {

    static let accessManager = CreateObjectsManager()

    func createArrayObjectRepos(arrayRepos:NSArray) -> [ObjectRepos]{
        let arrayAllObjectRepos = NSMutableArray()
        for infoRepos in arrayRepos {
            let info:NSDictionary = infoRepos as! NSDictionary
            let objRepos = ObjectRepos(dictionary: info)
            arrayAllObjectRepos.add(objRepos)
        }
        
        let firstNameSortDescriptor = NSSortDescriptor(key: "dateLastUpdate", ascending: false)
        let sortedByFirstName = (arrayAllObjectRepos as NSArray).sortedArray(using: [firstNameSortDescriptor])
        
        return sortedByFirstName as! [ObjectRepos]
    }
}
