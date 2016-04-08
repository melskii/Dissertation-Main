//
//  UserViewController.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 21/02/2016.
//  Copyright (c) 2016 Mel Schatynski. All rights reserved.
//

import UIKit
import SpriteKit

protocol UserDelegate {
    
    func setUserDetals ()
    
}

class UserViewController: UIViewController {
    

    var userDelegate: UserDelegate?
    
    @IBOutlet weak var skview: SKView!
    @IBOutlet var txtParticipant: UITextField!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var lblError: UILabel!

    override func loadView() {
        
        super.loadView()
        
    }
  
//    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        lblError.hidden = true
        txtName.text = USER.getUsersName()
     
    }

    @IBAction func btnOKTouchDown(sender: AnyObject) {
        
        lblError.text = ""
        lblError.hidden = true
        
        
        let name = txtName.text
        let id = txtParticipant.text == "" ? nil : txtParticipant.text
        
        if Regex(regex: "(([a-z]|[A-Z])+(\\s?))+", text: name).match() {
         
            
            USER.setUsersName(name!)
            
            if Regex(regex: "(\\d+)", text: id).match() {
            
                USER.setUserDetails(id!) {
                    (status: UserStatus) in
                    if status == UserStatus.Active
                    {
                        self.returnToPreviousController()
                        USER.syncProgress(0)
                    
                    }
                    
                    else if status != UserStatus.Active {

                    
                        self.lblError.hidden = false
                        self.lblError.text = "Participant Error: \(status.rawValue)"
                        
                        print ("got back: \(status.rawValue)")
                        
                    }
                    
                }
            }
            
            else if (id == nil) {
                
                self.returnToPreviousController()
                
            }
            
        }
        
        else {
            
        
            if let tf = self.txtName {
                
                tf.text = ""
            }
            
            
            lblError.text = "Enter a Name"
            lblError.hidden = false
            
        }
        
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
  
    
    @IBAction func btCancelTouchDown(sender: AnyObject) {
        
        returnToPreviousController()
    }
    
    func returnToPreviousController() {
        
        self.dismissViewControllerAnimated(true, completion: {});
        

    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

class Regex {
    
    let regex: String!
    let text: String!
    
    init(regex: String!, text: String!) {
        
        self.regex = regex
        self.text = text
        
    }
    
    
    func match() -> Bool {
        
        if text == nil {
            
            return false
        }
        
        do {
            
            let regex = try NSRegularExpression(pattern: self.regex, options: [])
            let nsString = self.text as NSString
            
            let results = regex.matchesInString(text,
                options: [], range: NSMakeRange(0, nsString.length))
            

            results.map { nsString.substringWithRange($0.range)} // Don't think this line is needed
            
            print(results.count == 1 ? "valid regex \(self.regex)" : "invalid regex \(self.regex)")
            return results.count == 1 ? true : false
            
        } catch let error as NSError {
            
            print("invalid regex: \(error.localizedDescription)")
            return false
            
        }
    }

    
    
}
