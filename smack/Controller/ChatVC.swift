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
    @IBOutlet weak var channelNameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer((self.revealViewController().panGestureRecognizer()))
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector (ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_notif:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserbyEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
        
    }
    
    @objc func channelSelected (_notif: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel () {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLbl.text = "#\(channelName)"
    }
    
    @objc func userDataDidChange (_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        }else{
            channelNameLbl.text = "Please log in"
        }
    }
    
    func onLoginGetMessages () {
        MessageService.instance.findAllChannel { (success) in
            if success {
                
            }
        }
    }
    
}
