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
    private var name: String! = ""
    private var active: Bool = false
    private var attempts: [Int:Int] = [:]
    private var timeToComplete: [Int:Int] = [:]
    private var rewards: [Int: Int] = [:]
    var unlockedLevel: Int = 0
    
    public init() {
    
    }
    
    func setUsersName(name: String) {
        
        self.name = name
    }
    
    func getUsersName() -> String?{
        
        
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
                        let _id = item["id"] as? String,
                        let _level = item["unlockedLevel"] as? String else {
                            
                            completion(status: UserStatus.NoUser)
                            return;
                    }
                    
                    self.id = Int(_id)
                    self.unlockedLevel = Int(_level)!
                    
                    print(self.unlockedLevel)
                    
                    if _active == "1" {
                        
                        self.active = true
                        completion(status: UserStatus.Active)
             
                    }
                    else {
                        self.active = false
                        completion(status: UserStatus.Disabled)       
                    }
                    
                    
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
    
    public func syncProgress (level: Int) {
        
        if active {
            
            let start = level == 0 ? 1 : level
            let end = level == 0 ? MAXLEVELS : level
            
            for var i = start; i <= end; i++ {
                
                let stars = rewards[i] == nil ? 0 : rewards[i]
                let time = timeToComplete[i] == nil ? 0 : timeToComplete[i]
           
                let request = NSMutableURLRequest(URL: NSURL(string: URL + "syncProgress.php")!)
                request.HTTPMethod = "POST"
                let postString = "filter=sync&id=\(id)&level=\(i)&time=\(time!)&stars=\(stars!)"
                request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
                
                print(postString)
                
                let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                    data, response, error in
                    
                    if error != nil {
                        
                        print("ERRORSTRING=\(error)")
                        print(UserStatus.BadConn.rawValue)
                        return
                    }
                    
                    print("response = \(response)")
                    
                    let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("RESPONSESTRING \(i) = \(responseString)")
                    
                    
                    var json: Array<AnyObject>!
                    
                    do {
                        json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? Array
                    } catch {
                        
//                        print(json)
                        print(error)
                    }
                    
                    /* https://www.raywenderlich.com/120442/swift-json-tutorial */
                    
                    if json != nil {
                    
                        //Extract the Time To Complete and Rewards
                        guard !(json.isEmpty),
                            let item = json[0] as? [String: AnyObject] ,
                            let _time = item["time_to_complete"] as? String,
                            let _stars = item["stars"] as? String,
                            let _level = item["level"] as? String else {

                                return;
                        }

                        self.rewards[Int(_level)!] = Int(_stars)
                        self.timeToComplete[Int(_level)!] = Int(_time)
                        
                     

                        print("active \(_time) id \(_stars)")
                    }
                
                    
                }
                task.resume()
    
                
                
            }
            
        }
        
    }
    
    func appendTimeToComplete (time: Int) {
        
        
        timeToComplete[_LEVEL] = time
        self.appendRewards()
        
        if active {
            
            syncProgress (_LEVEL)

        }
        
    }
    
    private func appendRewards() {
        
        var stars = 0
        
        if attempts[_LEVEL] >= 5 {
            
            stars = 1
            
        }
            
        else if attempts[_LEVEL] >= 3 {
            
            stars = 2
            
        }
            
        else if attempts[_LEVEL] >= 1 {
            
            stars = 3
            
        }
        
        if stars > (rewards[_LEVEL] == nil ? 0 : rewards[_LEVEL]) {
            
            rewards[_LEVEL] = stars
            
        }
        
        syncProgress (_LEVEL)
        
        print("rewards: \(rewards)")
        
    }
    
    func getRewardsStar(level: Int) -> Int {
  
        return rewards[level] == nil || rewards.count == 0 ? 0 : rewards[level]!
    }
    
    func appendAttempts () {
        
        attempts[_LEVEL] = (attempts[_LEVEL] == nil ? 1 : (attempts[_LEVEL]! + 1))
        
        
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
