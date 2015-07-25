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
        
        
        
        
        
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            println("Object has been saved.")
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

