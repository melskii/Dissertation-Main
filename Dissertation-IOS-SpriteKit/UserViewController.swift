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
        
        print("init user view")
    }
  
//    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        
        
        
    }

    @IBAction func btnOKTouchDown(sender: AnyObject) {
        
        
        if (txtParticipant.text != "")
        {
            let request = NSMutableURLRequest(URL: NSURL(string: "http://melbook.local/website/ipad/getData.php")!)
            request.HTTPMethod = "POST"
            let postString = "id=\(txtParticipant.text!)"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                if error != nil {
                    print("ERRORSTRING=\(error)")
                    return
                }
                
                print("response = \(response)")
                
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("RESPONSESTRING = \(responseString)")
            
                let values: NSArray = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                
                
                print("values \(values)")
                
                let userArray = values as! [String]
                
                if userArray.contains("id") {
                    
                    print("can I get a whoop whoop");
                    
                }
                
                
            }
            task.resume()
        }
        
        
        
//        returnToPreviousController()
        
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
