//
//  MessageRepository.swift
//  kvetch
//
//  Created by Jonah Stiennon on 5/10/15.
//  Copyright (c) 2015 Nirrius. All rights reserved.
//

import Foundation
import Parse

typealias Error = NSError

class MessageRepository {
    
    
    init(parseId: String, parseKey: String) {
        // id: "W35VTEicngcQGNj1oPbSRR4eaHOcaYkD0zw7Rmgf"
        // key: "u5aWKUJWqe3Nih2U3dQ1CC0iSEkBr3ybgMPBy8UN"
        Parse.setApplicationId(parseId, clientKey: parseKey)
        
    }
    
    func getMessages(cb: (messages: [Message]?, error: Error?) -> Void) {
       
        var recent = PFQuery(className: Message.parseClassName())
        recent.limit = 20
        
        recent.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if let messages = objects {
                cb(messages: (messages as! [Message]), error: error)
            } else {
                cb(messages: nil, error: error)
            }
        }
    }

}
