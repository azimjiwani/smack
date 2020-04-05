//
//  AuthService.swift
//  smack
//
//  Created by Azim Jiwani on 2020-04-04.
//  Copyright © 2020 Azim Jiwani. All rights reserved.
//

import Foundation
import Alamofire

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
        
        let header : HTTPHeaders = [
            "Content-Type" : "application/json; charset = UTF-8"
        ]
        
        let body = [
            "email" : lowerCaseEmail, "password" : password
        ]

        
        AF.request(URL_REGISTER, method: .post, parameters: body, encoder: URLEncodedFormParameterEncoder.default, headers: header, interceptor: nil).responseString {
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
        
}
    

