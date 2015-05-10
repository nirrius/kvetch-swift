//
//  MessageRepository.swift
//  kvetch
//
//  Created by Jonah Stiennon on 5/10/15.
//  Copyright (c) 2015 Nirrius. All rights reserved.
//

import Foundation
import Parse

class MessageRepository {
    init(parseId: String, parseKey: String) {
        //blah blah todo
    }
    
    func getMessages() -> [Message] {
        var messages = [
            Message(body: "hi", author: "Eric"),
            Message(body: "yo", author: "Jonah"),
            Message(body: "should'nt we say something important? First convo and all", author: "Eric"),
            Message(body: "let's fix our typos first ^^", author: "Jonah"),
            Message(body: "asshole....", author: "Eric")
        ]
        
        return messages
    }
}
