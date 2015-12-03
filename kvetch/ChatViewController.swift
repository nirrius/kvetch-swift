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
    var jonahsBlue : UIColor = UIColor.init(red: 108/255, green: 234/255, blue: 248/255, alpha: 0.5)

    var chatDataSource : chatTableViewDataSource
    var messageRepo : MessageRepository
    var newMessageTimer: dispatch_source_t!
    
    required init?(coder : NSCoder) {
        self.chatDataSource = chatTableViewDataSource()
        messageRepo = MessageRepository(parseId: "W35VTEicngcQGNj1oPbSRR4eaHOcaYkD0zw7Rmgf", parseKey: "u5aWKUJWqe3Nih2U3dQ1CC0iSEkBr3ybgMPBy8UN")
        super.init(coder: coder)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let logInButton = TWTRLogInButton(logInCompletion: {
//            (session: TWTRSession!, error: NSError!) in
//            // play with Twitter session
//        })
//        logInButton.center = self.view.center
//        self.view.addSubview(logInButton)

        func addTable(x : Float, y: Int , w : Int, h : Int, color: UIColor) -> UITableView {
            let rect = CGRectMake(CGFloat(x), CGFloat(y), CGFloat(w), CGFloat(h))
            let table = UITableView(frame: rect, style: UITableViewStyle.Plain)
            table.backgroundColor = color
            table.registerClass(UITableViewCell.self, forCellReuseIdentifier: "chatCell")
            table.dataSource = self.chatDataSource
            table.reloadData()
            self.view.addSubview(table)
            return table
        }
        
        func addInputBox(x: Int, y: Int, w: Int, h: Int) -> UITextField {
            let rect = CGRectMake(CGFloat(x), CGFloat(y), CGFloat(w), CGFloat(h))
            let field = UITextField(frame: rect)
            //field.frame.size.height = CGFloat(h)
            //field.frame.size.width = CGFloat(w)
            field.backgroundColor = UIColor.yellowColor()
            field.isAccessibilityElement = true
            //self.view.addSubview(field)
            return field
        }
        
        let table = addTable(0, y: 0, w: Int(view.bounds.width), h: Int(view.bounds.height), color: jonahsBlue)
        
        messageRepo.getMessages { (messages, error) -> Void in
            self.chatDataSource.messageBuffer = messages!
            table.reloadData()
            print("reloaded table after getting messages")
        }
        
        let inputBox = addInputBox(100, y: 400, w: 200, h: 100)
        
        inputBox.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(inputBox)
        let bottomConstraint : NSLayoutConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:[inputBox]-50-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["inputBox": inputBox])[0] as NSLayoutConstraint
        let heightConstraint : NSLayoutConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:[inputBox(==70)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["inputBox": inputBox])[0] as NSLayoutConstraint
        let widthConstraint : NSLayoutConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:[inputBox(==superview)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["inputBox": inputBox, "superview":self.view])[0] as NSLayoutConstraint
        
        view.addConstraint(bottomConstraint)
        view.addConstraint(heightConstraint)
        view.addConstraint(widthConstraint)
        
        
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
                print("checking for new messages")
                self.messageRepo.getMessages { (currentMessages, error) -> Void in
                    if (currentMessages == nil || currentMessages!.count == 0) {
                        return
                    }
                    let oldLastId = self.chatDataSource.messageBuffer.last?.objectId
                    if (currentMessages!.last?.objectId != oldLastId) {
                        let newMessages = messageDelta(currentMessages!, oldLastId: oldLastId!)
                        closure(newMessages)
                    }
                }
            }
        }
        
        
        handleNewMessages { (messages: [Message]) -> Void in
            self.chatDataSource.messageBuffer += messages
            table.reloadData()
        }
        
        
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
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

