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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let logInButton = TWTRLogInButton(logInCompletion: {
            (session: TWTRSession!, error: NSError!) in
            // play with Twitter session
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)

        func addTable(x : Float, y: Int , w : Int, h : Int, color: UIColor) {
            var rect = CGRectMake(CGFloat(x), CGFloat(y), CGFloat(w), CGFloat(h))
            var table = UITableView(frame: rect, style: UITableViewStyle.Plain)
            table.backgroundColor = color
            self.view.addSubview(table)
        }
        
    
        addTable(0, 0, 10, 10, UIColor.redColor())
        addTable(10, 10, 10, 10, UIColor.blueColor())
        addTable(20, 20, 10, 10, UIColor.greenColor())
        addTable(30, 30, 20, 20, UIColor.redColor())
        addTable(50, 50, 40, 40, UIColor.blueColor())
        addTable(90, 90, 80, 80, UIColor.greenColor())
        addTable(170, 170, 160, 160, UIColor.redColor())
        addTable(230, 230, 320, 320, UIColor.blueColor())
        
        
        
        
        
        
        
        
        
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

