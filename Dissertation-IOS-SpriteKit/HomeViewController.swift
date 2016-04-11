//
//  HomeViewController.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 29/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import UIKit
import SpriteKit
import Darwin

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var btnExit: UIButton!
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
  
        if DEFAULTS == false {
            
            DEFAULTS = true
            
            let load: NSUserDefaults = NSUserDefaults.standardUserDefaults()
         
           
            let encodedUser = load.objectForKey("Users")
            
            if encodedUser != nil {
            
                if let user = NSKeyedUnarchiver.unarchiveObjectWithData(encodedUser as! NSData) as? NSUserData {
                    
                    USERDATA = user
                    
                    if USERDATA.usersIsEmpty() {
        
                        USERDATA.appendUserModel(UserModel())
                        USERDATA.setCurrentUser()
                        
                        
                    }
                    else {
                        
                        USERDATA.setCurrentUser()
                    }
                }
            }
            else {
                
                USERDATA.setRandomName()
                USERDATA.appendUserModel(UserModel())
                USERDATA.setCurrentUser()
            }
            

            print(USERDATA.name)
            
            
            
            let save: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            let encodedData = NSKeyedArchiver.archivedDataWithRootObject(USERDATA)
            
            save.setObject(encodedData, forKey: "Users")
            
        
            save.synchronize()

            
        }
        
        

    }

   
    /*
    Change default IOS preferences
    */
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func resetUser() {
        
        let alertController = UIAlertController(title: "Admin", message: "Are you sure you want to reset the User Data?", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .Cancel) { (action:UIAlertAction!) in
            
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Reset", style: .Default) { (action:UIAlertAction!) in
            
            USER = UserModel()
            USER.saveUserLocally()
            
            
            
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true, completion:nil)

        
    }

    @IBAction func btnExitTouchDown() {
        
    
        exit(0)
        
    }
    
}