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
        
//        txtParticipant.
    
        
        
        
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
            
                
                var json: Array<AnyObject>!
                
                do {
                    json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? Array
                } catch {
                    print(error)
                }
                
                
                print(json)
//               https://www.raywenderlich.com/120442/swift-json-tutorial
                
                guard let item = json[0] as? [String: AnyObject] ,
                    
                    let active = item["active"] as? String else {
                        return;
                    }
                
                
                if active == "1" {
                    
                    self.txtParticipant.text = nil
                    
                }
                print("ITEM \(item)")
                print("active?: \(active)")
                
                
//                let values: NSArray = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
//                
//                print("data \(data)")
                
//                let jsonDic = try! NSJSONSerialization.JSONObjectWithData(values.firstObject as! NSData, options: NSJSONReadingOptions.MutableContainers) as! Dictionary<String, AnyObject>;
                
//                print("values \(values.firstObject)")
                
//                var dict = self.convertStringToDictionary(values.firstObject as! String)
//                
//                print("dict \(dict)")
//            
////
////                if values.contains("id") {
////                    
////                    print("can I get a whoop whoop");
////                    
////                }
                
                
            }
            task.resume()
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
