//
//  ObjectRepos.swift
//  GitHub
//
//  Created by Alexei Karas on 24.06.2018.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import UIKit

class ObjectRepos: NSObject {

    var stringDescription         = NSString()
    var stringName                = NSString()
    var stringFullName            = NSString()
    var stringLanguage            = NSString()
    var stringUrlRepos            = NSString()
    @objc var dateLastUpdate      = Date()
    
    var idRepo = 0;
    var idOwner = 0;

    var openIssuesCount = 0;
    var forksCount = 0;
    var stargazersCount : Float = 0.0
    
    var dictionaryInfoAboutRepos = NSDictionary()
    
    convenience init(dictionary: NSDictionary) {
        self.init()
     
        let dictionaryOwner : NSDictionary = dictionary.object(forKey: "owner") as! NSDictionary

        
        idRepo              = dictionary.object(forKey: "id")               as! NSInteger
        idOwner             = dictionaryOwner.object(forKey: "id")          as! NSInteger
        
        if let language = dictionary["language"] as? String {
            stringLanguage = language  as NSString
        }
        
        stringName          = dictionary.object(forKey:"name")              as! NSString
        stringFullName      = dictionary.object(forKey:"full_name")         as! NSString
        stringDescription   = dictionary.object(forKey:"description")       as! NSString
        openIssuesCount     = dictionary.object(forKey:"open_issues_count") as! Int
        forksCount          = dictionary.object(forKey:"forks_count")       as! Int
        stargazersCount     = dictionary.object(forKey:"stargazers_count")  as! Float
        stringUrlRepos      = dictionary.object(forKey: "html_url")         as! NSString
        
        let stringDate      = dictionary.object(forKey: "updated_at")       as! String
        dateLastUpdate      = stringDate.toDate()
        
        dictionaryInfoAboutRepos = dictionary

    }
}
