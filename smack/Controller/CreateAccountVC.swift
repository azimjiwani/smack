//
//  CreateAccountVC.swift
//  smack
//
//  Created by Azim Jiwani on 2020-04-02.
//  Copyright © 2020 Azim Jiwani. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
// outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createAccntPressed(_ sender: Any) {
        guard let email = emailTxt.text, emailTxt.text != "" else {return}
        guard let pass = passTxt.text, passTxt.text != "" else {return}
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("registered user")
                AuthService.instance.loginUser(email: email, pass: pass, completion: { (success) in
                    if success {
                        print("loggedin user", AuthService.instance.authToken)
                    }
                })
            }
        }
    }
    
    
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
    
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    
    
}
