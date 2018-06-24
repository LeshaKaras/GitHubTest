//
//  ExtensionString.swift
//  GitHub
//
//  Created by Alexei Karas on 23.06.2018.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import UIKit

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func toDate() -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let dateLastUpdate = dateFormatter.date(from: self)!
        return dateLastUpdate
    }
    
}
    

