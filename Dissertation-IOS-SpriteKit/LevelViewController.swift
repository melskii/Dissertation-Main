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
    
    var imgBtnLvl1: UIImage!
    var imgBtnLvl2: UIImage!
    var imgBtnLvl3: UIImage!
    var imgBtnLvl4: UIImage!
    var imgBtnLvl5: UIImage!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let unlockedLevel = (USER.unlockedLevel + 1)
        
        btnLevel1.enabled = false
        btnLevel2.enabled = false
        btnLevel3.enabled = false
        btnLevel4.enabled = false
        btnLevel5.enabled = false
        
        
        imgBtnLvl1 = UIImage(named: "Level_1_Inactive")
        btnLevel1.setImage(imgBtnLvl1, forState: UIControlState.Normal)
        btnLevel1.imageView?.contentMode = .ScaleAspectFit
        
        imgBtnLvl2 = UIImage(named: "Level_2_Inactive")
        btnLevel2.setImage(imgBtnLvl2, forState: UIControlState.Normal)
        btnLevel2.imageView?.contentMode = .ScaleAspectFit
        
        imgBtnLvl3 = UIImage(named: "Level_3_Inactive")
        btnLevel3.setImage(imgBtnLvl3, forState: UIControlState.Normal)
        btnLevel3.imageView?.contentMode = .ScaleAspectFit
        
        imgBtnLvl4 = UIImage(named: "Level_4_Inactive")
        btnLevel4.setImage(imgBtnLvl4, forState: UIControlState.Normal)
        btnLevel4.imageView?.contentMode = .ScaleAspectFit
        
        imgBtnLvl5 = UIImage(named: "Level_5_Inactive")
        btnLevel5.setImage(imgBtnLvl5, forState: UIControlState.Normal)
        btnLevel5.imageView?.contentMode = .ScaleAspectFit
        
        imgLevel1.image = UIImage(named: "star0")
        imgLevel2.image = UIImage(named: "star0")
        imgLevel3.image = UIImage(named: "star0")
        imgLevel4.image = UIImage(named: "star0")
        imgLevel5.image = UIImage(named: "star0")
        
        if unlockedLevel >= 1 {
            
            imgLock1.hidden = true
            btnLevel1.enabled = true
            
            imgLevel1.image = UIImage(named: "star\(String(USER.getRewardsStar(1)))")
            
            imgBtnLvl1 = UIImage(named: "Level_1")
            btnLevel1.setImage(imgBtnLvl1, forState: UIControlState.Normal)
            btnLevel1.imageView?.contentMode = .ScaleAspectFit
            
            if unlockedLevel >= 2 {
                
                imgLock2.hidden = true
                btnLevel2.enabled = true
                
                imgLevel2.image = UIImage(named: "star\(String(USER.getRewardsStar(2)))")
                
                imgBtnLvl2 = UIImage(named: "Level_2")
                btnLevel2.setImage(imgBtnLvl2, forState: UIControlState.Normal)
                btnLevel2.imageView?.contentMode = .ScaleAspectFit
                
                if unlockedLevel >= 3 {
                    
                    imgLock3.hidden = true
                    btnLevel3.enabled = true
                    
                    imgLevel3.image = UIImage(named: "star\(String(USER.getRewardsStar(3)))")
                    
                    imgBtnLvl3 = UIImage(named: "Level_3")
                    btnLevel3.setImage(imgBtnLvl3, forState: UIControlState.Normal)
                    btnLevel3.imageView?.contentMode = .ScaleAspectFit
                    
                    if unlockedLevel >= 4 {
                        
                        imgLock4.hidden = true
                        btnLevel4.enabled = true
                        
                        imgLevel4.image = UIImage(named: "star\(String(USER.getRewardsStar(4)))")
                        
                        imgBtnLvl4 = UIImage(named: "Level_4")
                        btnLevel4.setImage(imgBtnLvl4, forState: UIControlState.Normal)
                        btnLevel4.imageView?.contentMode = .ScaleAspectFit
                        
                        if unlockedLevel >= 5 {
                            
                            imgLock5.hidden = true
                            btnLevel5.enabled = true
                            
                            imgLevel5.image = UIImage(named: "star\(String(USER.getRewardsStar(5)))")
                            
                            imgBtnLvl5 = UIImage(named: "Level_5")
                            btnLevel5.setImage(imgBtnLvl5, forState: UIControlState.Normal)
                            btnLevel5.imageView?.contentMode = .ScaleAspectFit
                            
                        }
                        
                    }
                    
                    
                }
                
            }
            
            
        }

    }
    
    
    @IBAction func btnLevelTouchDown(sender: AnyObject) {
    
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