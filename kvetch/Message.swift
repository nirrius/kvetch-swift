//
//  Message.swift
//  kvetch
//
//  Created by Jonah Stiennon on 5/10/15.
//  Copyright (c) 2015 Nirrius. All rights reserved.
//

import Parse

class Message : PFObject, PFSubclassing {
    @NSManaged var author : String
    @NSManaged var body : String
    
    override init() {
        super.init()
    }
    
    init(body: String, author: String) {
        super.init()
        self["author"] = author
        self["body"] = body
    }
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Message"
    }
    
}
