//
//  ObjectUser.swift
//  GitHub
//
//  Created by Alexei Karas on 24.06.2018.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import UIKit

class ObjectUser: NSObject {

    var stringAvatarUrl = NSString()
    var stringMail      = NSString()
    var stringName      = NSString()
    var stringUrlGit    = NSString()
    
    convenience init(dictionary: NSDictionary) {
        self.init()
        stringAvatarUrl = dictionary.object(forKey:"avatar_url")    as! NSString
        stringMail      = dictionary.object(forKey:"email")         as! NSString
        stringName      = dictionary.object(forKey:"name")          as! NSString
        stringUrlGit    = dictionary.object(forKey:"html_url")      as! NSString
    }
}
