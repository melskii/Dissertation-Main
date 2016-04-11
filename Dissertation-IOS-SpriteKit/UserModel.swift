//
//  UserProfile.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 20/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import Foundation


public class UserModel: NSObject, NSCoding {

    
    private var id: Int! = -1
    private var name: String! = ""
    private var active: Bool = false
    private var attempts: [Int:Int] = [:]
    private var timeToComplete: [Int:Int] = [:]
    private var rewards: [Int: Int] = [:]
    private var programs: [(level: Int, program: [Block], error: FeedbackType)] = [] //only stores here if offline
    var unlockedLevel: Int = 0
    
    public override  init() {
       
        super.init()
        
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(self, forKey: "user")
        
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeInteger(id, forKey: "id")
        aCoder.encodeBool(active, forKey: "active")
//        aCoder.encodeObject(attempts, forKey: "attempts")
        aCoder.encodeObject(timeToComplete, forKey: "timeToComplete")
        aCoder.encodeObject(rewards, forKey: "rewards")
//        aCoder.encodeObject(programs, forKey: "programs")
        aCoder.encodeInteger(unlockedLevel, forKey: "unlocked")
        
        
    }
    
    required convenience public init(coder aDecoder: NSCoder) {
        
        self.init()
        
        self.name = aDecoder.decodeObjectForKey("name") as! String
        self.id = aDecoder.decodeIntegerForKey("id")
        self.active = aDecoder.decodeBoolForKey("active")
//        self.attempts = aDecoder.decodeObjectForKey("attempts") as! [Int:Int]
        self.timeToComplete = aDecoder.decodeObjectForKey("timeToComplete") as! [Int:Int]
        self.rewards = aDecoder.decodeObjectForKey("rewards") as! [Int:Int]
//        self.programs = aDecoder.decodeObjectForKey("programs") as! [(level: Int, program: [Block], error: FeedbackType)]
        self.unlockedLevel = aDecoder.decodeIntegerForKey("unlocked")
        
        
//        self = aDecoder.decodeObjectForKey("user") as! [AnyObject]
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
                        
                        if Int(_level) > self.unlockedLevel {
                            
                            self.unlockedLevel = Int(_level)!
 
                        }
                        
                     

                        print("active \(_time) id \(_stars)")
                    }
                
                    
                }
                task.resume()
    
                
                
            }
            
            if programs.count > 0 {
                
                
                for program in programs {
                    
                    setProgramFlow(program.program, type: program.error, level: program.level)
                    
                }
                
                programs.removeAll()
                
            }
            
        }
        
        else {
            
            
            self.unlockedLevel = _LEVEL
//                self.unlockedLevel++
         
  
        }
        
        
        
    }
    
    func appendTimeToComplete (time: Int) {
        
        
        timeToComplete[_LEVEL] = time
        self.appendRewards()
        
        if active {
            
            syncProgress (_LEVEL)
            self.saveUserLocally()

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
        
        self.saveUserLocally()
        
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
    
    
    func setProgramFlow(program: [Block], type: FeedbackType, level: Int = _LEVEL) {
        
        
        
        if active {
            
            
            let programflow = programFlowToString(program)
            
            let request = NSMutableURLRequest(URL: NSURL(string: URL + "setProgramFlow.php")!)
            request.HTTPMethod = "POST"
            
            var postString = "id=\(id)&level=\(level)&program=\(programflow)"
            
            if type != FeedbackType.LevelComplete {
                postString = "id=\(id)&level=\(level)&program=\(programflow)&error=\(type.rawValue)"
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
        
        else {
            
            
            programs.append((level, program, type))
            print(programs)
            
        }
        
        self.saveUserLocally()
        
    }
    
    private func programFlowToString (program: [Block]) -> String {
        
        var x = ""
        
        for block in program {
            
            x += block.name + "|"
            
        }
        
        x = String(x.characters.dropLast())
        
        
        return x
        
    }
    
    func saveUserLocally() {
        
        print(USERDATA.user)
        
        USERDATA.appendUserModel(USER)
        
        let save: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let encodedData = NSKeyedArchiver.archivedDataWithRootObject(USERDATA)
        
        save.setObject(encodedData, forKey: "Users")
        
        
        save.synchronize()
        
        
        
    }
    

}

class NSUserData : NSObject, NSCoding {
    
    
//    private var user: [UserModel]!
    private var user: UserModel?
    private var current: Int = -1
    private var next: Int = 0
    var name: String!
    
    override init() {
        super.init()
        
        self.user = nil
        self.current = -1
        self.next = 0
        self.name = ""
        
      
    }
    
    func setRandomName()  {
        
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        var randomString : NSMutableString = NSMutableString(capacity: 10)
        
        for (var i=0; i < 10; i++){
            var length = UInt32 (letters.length)
            var rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        print(randomString)

        self.name = randomString as String
        
    }
    
    
    required convenience init(coder aDecoder: NSCoder) {
        
        //self.init(coder: aDecoder)
        self.init()
     
        
        self.user = aDecoder.decodeObjectForKey("user") as! UserModel
        self.current = aDecoder.decodeIntegerForKey("current")
        self.next = aDecoder.decodeIntegerForKey("next")
        self.name = aDecoder.decodeObjectForKey("name") as! String
    }
 
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(user, forKey: "user")
        aCoder.encodeInteger(current, forKey: "current")
        aCoder.encodeInteger(next, forKey: "next")
        aCoder.encodeObject(name, forKey: "name")
        
      
    }
    
    
    


  
    
    func appendUserModel (usr: UserModel) {
        
        user = usr
//        
//        if (user.count < 2) {
//            
//            user.append(usr)
//            
//            
//        }
//        
//        else {
//            
//            
//            user.insert(usr, atIndex: current)
//            
//        }
//        
//        current = next
//        
//        if (next == 2) {
//            
//            next = 0
//            
//        }
//            
//        else {
//            
//            next++
//            
//        }
        
    }
    
//    func getUsersName (i: Int) -> String {
//        
//        let u = user[i]
//        
//        return u.getUsersName() == nil ? "" : u.getUsersName()!
//    }
    
    func usersIsEmpty() -> Bool {
        
        
//        return user.count == 0 ? true : false
        
         return user == nil ? true : false
    }
    
//    func setUser (i: Int) {
//        
//        let usr: UserModel = user[i]
//        
//        USER = usr
//        current = i
//        
//    }
//    
    func setCurrentUser () {
        
        USER = user
        
//        for users in user {
//            
//            print(users)
//        }
//        
//        
//        if (user.count > 0)
//        {
//            let usr: UserModel = user[current]
//            USER = usr
//        }
//        else {
//            
//            
//            USER = UserModel()
//            
//            
//        }
        
    }
    
    func getCurrentUser() -> UserModel {
        
//        if (user.count > 0)
//        {
//            let usr: UserModel = user[current]
//            
//            return usr
//        }
//        
//        
//        return UserModel()
        
        if (user == nil)
        {
            return UserModel()
        }

        
        return user!
        
    }
    
    
    
    
}


