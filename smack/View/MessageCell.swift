//
//  MessageCell.swift
//  smack
//
//  Created by Azim Jiwani on 2020-04-12.
//  Copyright © 2020 Azim Jiwani. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

//    outlets
    
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell (message : Message) {
        messageBodyLbl.text = message.message
        userNameLbl.text = message.userName
//        timeStampLbl.text = message.timeStamp
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }
}
