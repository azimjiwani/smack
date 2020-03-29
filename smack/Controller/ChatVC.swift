//
//  ChatVC.swift
//  smack
//
//  Created by Azim Jiwani on 2020-03-29.
//  Copyright © 2020 Azim Jiwani. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

//    Outlets
    
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer((self.revealViewController().panGestureRecognizer()))
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        // Do any additional setup after loading the view.
    }
    
}
