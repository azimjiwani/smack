//
//  SocketService.swift
//  smack
//
//  Created by Azim Jiwani on 2020-04-11.
//  Copyright © 2020 Azim Jiwani. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService ()
    var socket = SocketManager(socketURL: URL(string: BASE_URL)!).defaultSocket
    
    override init() {
        super.init()
    }
    

//    var manager = SocketManager(socketURL : URL(string: BASE_URL)!)
//    var socket = SocketManager(socketURL : ).defaultSocket
    
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
    
    func establishConnection (){
        manager.defaultSocket.connect()
    }
    
    func closeConnection () {
        manager.defaultSocket.disconnect()
    }
    
    func addChannel (channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        manager.defaultSocket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel (completion: @escaping CompletionHandler) {
        manager.defaultSocket.on("channelCreated") {(dataArray, ack) in
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage (messageBody : String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        manager.defaultSocket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
}


