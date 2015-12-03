//
//  chatTableViewDataSource.swift
//  kvetch
//
//  Created by Jonah Stiennon on 5/23/15.
//  Copyright (c) 2015 Nirrius. All rights reserved.
//

import Foundation

class chatTableViewDataSource : NSObject, UITableViewDataSource {
    
    var messageBuffer : [Message] = [Message]()

    
    override init() {
            }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 // This was put in mainly for my own unit testing
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("chatCell", forIndexPath: indexPath) 
        
        // cell.detailTextLabel?.text = "detail text label"
        let message : Message = messageBuffer[indexPath.item]
        cell.textLabel?.text = message.objectForKey("body") as? String
        cell.textLabel?.isAccessibilityElement = true
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageBuffer.count
    }
}
