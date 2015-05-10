//
//  Message.swift
//  kvetch
//
//  Created by Jonah Stiennon on 5/10/15.
//  Copyright (c) 2015 Nirrius. All rights reserved.
//

import Foundation

class Message {
    var author = "Anonymous"
    var body = ""
    
    init(body: String, author: String) {
        self.author = author
        self.body = body
    }
}
