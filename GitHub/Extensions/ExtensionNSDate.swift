//
//  ExtensionNSDate.swift
//  GitHub
//
//  Created by Alexei Karas on 24.06.2018.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import UIKit

extension Date {
    
    func dateToString() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM yyyy"
        let stringDate: String = formatter.string(from:self)

        return stringDate
    }
    
}
