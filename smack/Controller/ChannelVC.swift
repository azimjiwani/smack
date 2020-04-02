//
//  ChannelVC.swift
//  smack
//
//  Created by Azim Jiwani on 2020-03-29.
//  Copyright © 2020 Azim Jiwani. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

//    Outlets
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    

}
