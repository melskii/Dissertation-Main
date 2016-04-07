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
    private var attempts: [Int:Int] = [:]
    private var timeToComplete: [Int:Int] = [:]
    private var rewards: [Int: Int] = [:]
    
    public init() {
    
        
        self.name = "Mel"
        
        
    }
    
    func getParticipantName() -> String?{
        
        
        return name
    }
    
    public func setUserDetails (tag: String, completion: (status: UserStatus) -> Void) {
        
        if let id = Int(tag) {
            
            if id != self.id {
                
                active = false
                self.id = -1
                
                let request = NSMutableURLRequest(URL: NSURL(string: URL + "getData.php")!)
                request.HTTPMethod = "POST"
                let postString = "id=\(id)"
                request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
                
                let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                    data, response, error in
                    
                    if error != nil {
                        
                        print("ERRORSTRING=\(error)")
                        completion(status: UserStatus.BadConn)
                        return
                    }
                    
                    print("response = \(response)")
                    
                    let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("RESPONSESTRING = \(responseString)")
                    
                    
                    var json: Array<AnyObject>!
                    
                    do {
                        json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? Array
                    } catch {
                        
                        completion(status: UserStatus.BadJSON)
                        print(json)
                        print(error)
                    }
              
                    /* https://www.raywenderlich.com/120442/swift-json-tutorial */
                    
                    //Extract the User ID and Active Status
                    guard !(json.isEmpty),
                    let item = json[0] as? [String: AnyObject] ,
                        let _active = item["active"] as? String,
                        let _id = item["id"] else {
                            
                            completion(status: UserStatus.NoUser)
                            return;
                    }
                    
                    if _active == "1" {
                        
                        self.active = true
                        completion(status: UserStatus.Active)
             
                    }
                    else {
                        self.active = false
                        completion(status: UserStatus.Disabled)       
                    }
                    
                    self.id = Int(_id as! String)
                    print("active \(self.active) id \(self.id)")
   
                    
                }
                task.resume()
                
            }
            
            else {
                
                if active {
                    completion(status: UserStatus.Active)
                } else {
                    completion(status: UserStatus.Disabled)
                }
                
            }
            
        }
        
        else {
            
            completion(status: UserStatus.Invalid)
        }
        
    }
    
    func appendTimeToComplete (time: Int) {
        
        
        timeToComplete[_LEVEL] = time
        
        if active {
            
            
            let request = NSMutableURLRequest(URL: NSURL(string: URL + "setCompleteLevel.php")!)
            request.HTTPMethod = "POST"
            
            let postString = "id=\(self.id)&level=\(_LEVEL)&time=\(time)"

            
            
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
    
                
            }
            
            task.resume()
            
            
            
        }
        
    }
    
    func appendAttempts () {
        
        attempts[_LEVEL] = attempts[_LEVEL] == nil ? 1 : attempts[_LEVEL]! + 1
        
        print(attempts)
        
    }
    
    func resetAttempts() {
        
        attempts[_LEVEL] = 0
        
    }
    
    
    func setProgramFlow(program: [Block], type: String?) {
        
        if active {
            
            
            let programflow = programFlowToString(program)
            
            let request = NSMutableURLRequest(URL: NSURL(string: URL + "setProgramFlow.php")!)
            request.HTTPMethod = "POST"
            
            var postString = "id=\(id)&level=\(_LEVEL)&program=\(programflow)"
            
            if type != nil {
                postString = "id=\(id)&level=\(_LEVEL)&program=\(programflow)&error=\(type!)"
            }
            
            
            
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
                
                
                //                var json: Array<AnyObject>!
                //
                //                do {
                //                    json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? Array
                //                } catch {
                //                    print(error)
                //                }
                
            }
            
            task.resume()
            
            
        }
        
    }
    
    private func programFlowToString (program: [Block]) -> String {
        
        var x = ""
        
        for block in program {
            
            x += block.name + "|"
            
        }
        
        x = String(x.characters.dropLast())
        
        
        return x
        
    }

}
