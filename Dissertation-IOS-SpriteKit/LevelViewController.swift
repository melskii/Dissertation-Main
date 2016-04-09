//
//  LevelViewController.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 07/04/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import Foundation
import SpriteKit

class LevelViewController: UIViewController {
    
    @IBOutlet var imgLock1: UIImageView!
    @IBOutlet var imgLock2: UIImageView!
    @IBOutlet var imgLock3: UIImageView!
    @IBOutlet var imgLock4: UIImageView!
    @IBOutlet var imgLock5: UIImageView!
    
    @IBOutlet var btnLevel1: UIButton!
    @IBOutlet var btnLevel2: UIButton!
    @IBOutlet var btnLevel3: UIButton!
    @IBOutlet var btnLevel4: UIButton!
    @IBOutlet var btnLevel5: UIButton!
    
    
    @IBOutlet var imgLevel1: UIImageView!
    @IBOutlet var imgLevel2: UIImageView!
    @IBOutlet var imgLevel3: UIImageView!
    @IBOutlet var imgLevel4: UIImageView!
    @IBOutlet var imgLevel5: UIImageView!

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let unlockedLevel = (USER.unlockedLevel + 1)
        
        btnLevel1.enabled = false
        btnLevel2.enabled = false
        btnLevel3.enabled = false
        btnLevel4.enabled = false
        btnLevel5.enabled = false
        
        
        imgLevel1.image = UIImage(named: "star0")
        imgLevel2.image = UIImage(named: "star0")
        imgLevel3.image = UIImage(named: "star0")
        imgLevel4.image = UIImage(named: "star0")
        imgLevel5.image = UIImage(named: "star0")
        
        if unlockedLevel >= 1 {
            
            imgLock1.hidden = true
            btnLevel1.enabled = true
            
            imgLevel1.image = UIImage(named: "star\(String(USER.getRewardsStar(1)))")
            
            if unlockedLevel >= 2 {
                
                imgLock2.hidden = true
                btnLevel2.enabled = true
                
                imgLevel2.image = UIImage(named: "star\(String(USER.getRewardsStar(2)))")
                
                print(String(USER.getRewardsStar(2)))
                
                print(imgLevel2.image)
                
                if unlockedLevel >= 3 {
                    
                    imgLock3.hidden = true
                    btnLevel3.enabled = true
                    
                    imgLevel3.image = UIImage(named: "star\(String(USER.getRewardsStar(3)))")
                    
                    if unlockedLevel >= 4 {
                        
                        imgLock4.hidden = true
                        btnLevel4.enabled = true
                        
                        imgLevel4.image = UIImage(named: "star\(String(USER.getRewardsStar(4)))")
                        
                        if unlockedLevel == 5 {
                            
                            imgLock5.hidden = true
                            btnLevel5.enabled = true
                            
                            imgLevel5.image = UIImage(named: "star\(String(USER.getRewardsStar(5)))")
                            
                        }
                        
                    }
                    
                    
                }
                
            }
            
            
        }

    }
    
    
    @IBAction func btnLevelTouchDown(sender: AnyObject) {
        
        print(sender.tag)
        _LEVEL = sender.tag
        LEVEL = Level(level: _LEVEL)
        performSegueWithIdentifier("showLevelSegue", sender: sender)
        
    }
    
    
    /*
    Change default IOS preferences
    */
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}