//
//  MessageService.swift
//  smack
//
//  Created by Azim Jiwani on 2020-04-10.
//  Copyright © 2020 Azim Jiwani. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message] ()
    var selectedChannel : Channel?

    func findAllChannel (completion: @escaping CompletionHandler) {
        
        AF.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER, interceptor: nil).responseJSON {
                (response) in
        
                switch response.result {
                    case .success:
                        do {
                            guard let data = response.data else {return}
                            if let json = try JSON(data: data).array {
                                for item in json {
                                    let name = item["name"].stringValue
                                    let channelDescription = item["description"].stringValue
                                    let id = item["_id"].stringValue
                                    let channel = Channel (channelTitle: name, channelDescription: channelDescription, id: id)
                                    self.channels.append(channel)
                                }
                            }
                        } catch {
    //                       print(error)
                        }
                        NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                        completion(true)
                    case let .failure(error):
                        completion(false)
                        debugPrint(response.result as Any)
                }
            }
        }
    
    func findAllMessagesForChannel (channelId : String, completion: @escaping CompletionHandler) {
        
        AF.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER, interceptor: nil).responseJSON { (response) in
            
            switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {return}
                        if let json = try JSON(data: data).array {
                            for item in json {
                                let messageBody = item["messageBody"].stringValue
                                let channelId = item["channelId"].stringValue
                                let id = item["_id"].stringValue
                                let userName = item["userName"].stringValue
                                let userAvatar = item["userAvatar"].stringValue
                                let userAvatarColor = item["userAvatarColor"].stringValue
                                let timeStamp = item["timeStamp"].stringValue
                                
                                
                                let message = Message (message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                                self.messages.append(message)
                                
                            }
                        }
                    } catch {
//                       print(error)
                    }
                    completion(true)
                    print(self.messages)
                case let .failure(error):
                    debugPrint(response.result as Any)
                completion(false)
            }
        }
    }
        
    func clearMessages () {
        messages.removeAll()
    }
    
    func clearChannels () {
        channels.removeAll()
    }
}

