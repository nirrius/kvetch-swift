//
//  FirstViewController.swift
//  kvetch
//
//  Created by Teffen Ellis on 5/10/15.
//  Copyright (c) 2015 Nirrius. All rights reserved.
//

import UIKit
import Parse
import TwitterKit

class ChatViewController: UIViewController {

    var chatDataSource : chatTableViewDataSource
    var messageRepo : MessageRepository
    var newMessageTimer: dispatch_source_t!
    
    required init(coder : NSCoder) {
        self.chatDataSource = chatTableViewDataSource()
        messageRepo = MessageRepository(parseId: "W35VTEicngcQGNj1oPbSRR4eaHOcaYkD0zw7Rmgf", parseKey: "u5aWKUJWqe3Nih2U3dQ1CC0iSEkBr3ybgMPBy8UN")
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let logInButton = TWTRLogInButton(logInCompletion: {
            (session: TWTRSession!, error: NSError!) in
            // play with Twitter session
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)

        func addTable(x : Float, y: Int , w : Int, h : Int, color: UIColor) -> UITableView {
            var rect = CGRectMake(CGFloat(x), CGFloat(y), CGFloat(w), CGFloat(h))
            var table = UITableView(frame: rect, style: UITableViewStyle.Plain)
            table.backgroundColor = color
            table.registerClass(UITableViewCell.self, forCellReuseIdentifier: "chatCell")
            table.dataSource = self.chatDataSource
            table.reloadData()
            self.view.addSubview(table)
            return table
        }
        
    
        let table = addTable(0, 0, Int(view.bounds.width), Int(view.bounds.height), UIColor.yellowColor())
        
        messageRepo.getMessages { (messages, error) -> Void in
            self.chatDataSource.messageBuffer = messages!
            table.reloadData()
            println("reloaded table after getting messages")
        }
        
        func messageDelta(currentMessages: [Message], oldLastId: String) -> [Message] {
            var indexOfOld = -1;
            for i in 0..<currentMessages.count {
                if (currentMessages[i].objectId == oldLastId) {
                    indexOfOld = i;
                }
            }
            return Array<Message>(currentMessages[indexOfOld+1..<currentMessages.count])
        }
        
        func handleNewMessages(closure: ([Message]) -> Void) -> Void {
            newMessageTimer = interval(1) {
                println("checking for new messages")
                self.messageRepo.getMessages { (currentMessages, error) -> Void in
                    if (currentMessages == nil || currentMessages!.count == 0) {
                        return
                    }
                    let oldLastId = self.chatDataSource.messageBuffer.last?.objectId
                    if (currentMessages!.last?.objectId != oldLastId) {
                        let newMessages = messageDelta(currentMessages!, oldLastId!)
                        closure(newMessages)
                    }
                }
            }
        }
        
        
        handleNewMessages { (messages: [Message]) -> Void in
            self.chatDataSource.messageBuffer += messages
            table.reloadData()
        }
        
        
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            println("Object has been saved.")
//        }
    }
    
    func interval(interval: UInt64, closure: () -> Void) -> dispatch_source_t! {
        let queue = dispatch_queue_create("com.domain.app.timer", nil)
        let timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, interval * NSEC_PER_SEC, 1 * NSEC_PER_SEC)
        dispatch_source_set_event_handler(timer, closure)
        dispatch_resume(timer)
        return timer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

