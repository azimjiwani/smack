//
//  UserDataService.swift
//  smack
//
//  Created by Azim Jiwani on 2020-04-06.
//  Copyright © 2020 Azim Jiwani. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData (id: String, color: String, avatarName: String, email: String, name: String) {
        
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName (avatarName: String) {
        self.avatarName = avatarName
    }
    
    func returnUIColor (components: String) -> UIColor {
        
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g ,b, a : NSString?
        
        r = scanner.scanUpToString(",") as NSString?
        g = scanner.scanUpToString(",") as NSString?
        b = scanner.scanUpToString(",") as NSString?
        a = scanner.scanUpToString(",") as NSString?
//        scanner.scanUpTo(from: comma, into: &r)
//        scanner.scanUpToCharacters(from: comma, into: &g)
//        scanner.scanUpToCharacters(from: comma, into: &b)
//        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defualtColor = UIColor.lightGray
        
        guard let rUnwrapped = r else {return defualtColor}
        guard let gUnwrapped = g else {return defualtColor}
        guard let bUnwrapped = b else {return defualtColor}
        guard let aUnwrapped = a else {return defualtColor}
        
        let rfloat = CGFloat(r!.doubleValue)
        let gfloat = CGFloat(g!.doubleValue)
        let bfloat = CGFloat(b!.doubleValue)
        let afloat = CGFloat(a!.doubleValue)
        
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newUIColor
    }
    
    func logoutUser() {
        
        id = ""
        avatarColor = ""
        avatarName = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        MessageService.instance.clearChannels()
    }
    
}
