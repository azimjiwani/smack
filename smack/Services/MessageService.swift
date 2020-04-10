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
                        print(self.channels[0].channelTitle!)
                        completion(true)
                    case let .failure(error):
                        completion(false)
                        debugPrint(response.result as Any)
                }
            }
        
    }
    
}
