//
//  AuthService.swift
//  smack
//
//  Created by Azim Jiwani on 2020-04-04.
//  Copyright © 2020 Azim Jiwani. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService{
    static let instance = AuthService  ()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken : String{
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set{
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail : String{
           get {
               return defaults.value(forKey: USER_EMAIL) as! String
           }
           set{
               defaults.set(newValue, forKey: USER_EMAIL)
           }
       }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        
        let body = [
            "email" : lowerCaseEmail, "password" : password
        ]

        AF.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER, interceptor: nil).response {
            (response) in
    
            switch response.result {
                case .success:
                    completion(true)
                case let .failure(error):
                    completion(false)
                    debugPrint(response.result as Any)
            }
        }
    }
        
    func loginUser (email: String, pass: String, completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        
        let body = [
            "email" : lowerCaseEmail, "password" : pass
        ]
        
        AF.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER, interceptor: nil).responseJSON { (response) in
            switch response.result {
                case .success(let value) :
//                        if let json = value as? Dictionary <String, Any> {
//                            if let email = json["user"] as? String {
//                                self.userEmail = email
//                            }
//                            if let token = json["token"] as? String {
//                                  self.authToken = token
//                          }
//                        }
//                    Using SWITFYJSON
                    do {
                        guard let data = response.data else { return }
                        let json = try JSON(data: data)
                        self.userEmail = json["user"].stringValue
                        self.authToken = json["token"].stringValue
                        
                    }catch {
//                       print(error)
                    }
                    
                    self.isLoggedIn = true
                    completion(true)
                case let .failure(error):
                    completion(false)
                    debugPrint(response.result as Any)
            }
        }
        
    }
    
    func createUser(name:String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body = [
            "name" : name,
            "email" : lowerCaseEmail,
            "avatarName" : avatarName,
            "avatarColor" : avatarColor
            
        ]
        
        AF.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER, interceptor: nil).responseJSON { (response) in
            
            switch response.result {
                case .success:
                    do {
                        guard let data = response.data else { return }
                        let json = try JSON(data: data)
                        let id = json["_id"].stringValue
                        let color = json["avatarColor"].stringValue
                        let avatarName = json["avatarName"].stringValue
                        let email = json["email"].stringValue
                        let name = json["name"].stringValue
                        
                        UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
                        
                    } catch {
//                       print(error)
                    }
                    
                    completion(true)
                case let .failure(error):
                    completion(false)
                    debugPrint(response.result as Any)
            }
        }
        
    }
    
    func findUserbyEmail (completion: @escaping CompletionHandler) {
        
        AF.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER, interceptor: nil).responseJSON { (response) in
                    
            switch response.result {
                case .success:
                    do {
                        guard let data = response.data else { return }
                        let json = try JSON(data: data)
                        let id = json["_id"].stringValue
                        let color = json["avatarColor"].stringValue
                        let avatarName = json["avatarName"].stringValue
                        let email = json["email"].stringValue
                        let name = json["name"].stringValue
                        
                        UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
                        
                    } catch {
//                       print(error)
                    }
                    
                    completion(true)
                case let .failure(error):
                    completion(false)
                    debugPrint(response.result as Any)
            }
        }
    }
}
