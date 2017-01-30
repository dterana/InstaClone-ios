//
//  ViewController.swift
//  InstaClone-ios
//
//  Created by Pourpre on 1/30/17.
//  Copyright © 2017 Pourpre. All rights reserved.
//

import UIKit

import Parse

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let user = PFObject(className: "Users")
        
        user["name"] = "Bob"
        
        user.saveInBackground { (success, error) -> Void in
            
            if success {
                
                print("Object has been saved.")
                
            } else {
                
                if error != nil {
                    
                    print (error!)
                    
                } else {
                    
                    print ("Error")
                }
                
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

