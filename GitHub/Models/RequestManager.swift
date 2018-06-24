//
//  RequestManager.swift
//  GitHub
//
//  Created by Alexei Karas on 21.06.2018.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import UIKit
import Alamofire

class RequestManager: NSObject {

    static let accessManager = RequestManager()
    
    let host : String = "https://api.github.com"
    
    //MARK: GET Requests
    func authorizationUser(nick:String, password:String , completionHandler:@escaping (Bool) -> ()) {
        
        let authorization = (nick + ":" + password).toBase64();

        let headers = [
            "Content-Type" : "application/json",
            "Authorization": "Basic " + authorization
        ]
        
        let request = host
        Alamofire.request(request,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: headers ).responseJSON { resultRequest in
                            
                            if resultRequest.response?.statusCode == 200 {
                                DataManager.accessManager.createLogInUser(nick: nick, password: password)
                                completionHandler(true)
                            } else {
                                completionHandler(false)
                            }
        }
    }
    
    
    func getInfoAboutUser(completionHandler:@escaping (ObjectUser) -> ()) {
        
        let user = DataManager.accessManager.executeFetchRequestUserInArray().first
        let authorization = ((user?.nickUser)! + ":" + (user?.passwordUser)!).toBase64();

        let headers = [
            "Content-Type" : "application/json",
            "Authorization": "Basic " + authorization
        ]
        
        let request = host + "/users/" + (user?.nickUser)!
        Alamofire.request(request,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: headers ).responseJSON { resultRequest in
                            
                            if resultRequest.response?.statusCode == 200 {

                                if let result = resultRequest.result.value {
                                    let JSON = result as! NSDictionary
                                    completionHandler(ObjectUser(dictionary: JSON))
                                }
                                
                            } else {
                                completionHandler(ObjectUser())
                            }
        }
    }
    
    func getReposUser(completionHandler:@escaping (Bool,[ObjectRepos]) -> ()) {
        
        let user = DataManager.accessManager.executeFetchRequestUserInArray().first
        let authorization = ((user?.nickUser)! + ":" + (user?.passwordUser)!).toBase64();
        
        let headers = [
            "Content-Type" : "application/json",
            "Authorization": "Basic " + authorization
        ]
        
        let request = host + "/users/" + (user?.nickUser)! + "/repos"
        Alamofire.request(request,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: headers ).responseJSON { resultRequest in
                            
                            if resultRequest.response?.statusCode == 200 {
                                
                                if let result = resultRequest.result.value {
                                    let arrayAllRepos = result as! NSArray
                                    let arrayObjectsAllRepos = CreateObjectsManager.accessManager.createArrayObjectRepos(arrayRepos: arrayAllRepos)
                                    completionHandler(true,arrayObjectsAllRepos)
                                }

                            } else {
                                completionHandler(false,[])
                            }
        }
    }
    
    //MARK: DELETE
    
    
    func deleteRepository(nameRepos:NSString, completionHandler:@escaping (Bool) -> ()) {
        
        let user = DataManager.accessManager.executeFetchRequestUserInArray().first
        let authorization = ((user?.nickUser)! + ":" + (user?.passwordUser)!).toBase64();
        
        let headers = [
            "Content-Type" : "application/json",
            "Authorization": "Basic " + authorization
        ]
        
        let request = host + "/repos/" + (user?.nickUser)! + "/\(nameRepos)"

        Alamofire.request(request,
                          method: .delete,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: headers ).responseJSON { resultRequest in
                            
                            if resultRequest.response?.statusCode == 204 {
                                completionHandler(true)
                            } else {
                                completionHandler(false)
                            }
        }
    }
    
    
}


















