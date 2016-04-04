//
//  UserProfile.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 20/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import Foundation


public class UserModel {

    
    private var id: Int! = -1
    private var name: String?
    private var active: Bool = false
    
    public init() {
    
        
        self.name = "Mel"
        
        
    }
    
    func getParticipantName() -> String?{
        
        
        return name
    }
    
    func validUser (participant: String) -> Bool
    {
        if let id = Int(participant) {
            
            if id != self.id {
                
                
                self.setUserDetails(id)
                
                return active
                
            }
            
            
        }
        
        return active
    }
    
    private func setUserDetails (participant: Int) {
        
        self.active = false
        self.id = -1
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://melbook.local/website/ipad/getData.php")!)
        request.HTTPMethod = "POST"
        let postString = "id=\(participant)"
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
                
                let active = item["active"] as? String, let id = item["id"] else {
                    return;
            }
            
            
            self.active = Int(active) == 1 ? true : false
            self.id = Int(id as! String)
            
            
            print("active \(active) id \(id)")
            
            
        }
        task.resume()
        
    }
    
    
    
    


}