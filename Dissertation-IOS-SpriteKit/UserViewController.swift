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

    override func loadView() {
        
        super.loadView()
        
    }
  
//    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        txtParticipant.
    
        
        
        
    }

    @IBAction func btnOKTouchDown(sender: AnyObject) {
        
        
        if (txtParticipant.text != "")
        {
            let valid = USER.validUser(txtParticipant.text!)
            
            print("valid: \(valid)")
        }
        
        
        
//        returnToPreviousController()
        
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
