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
    
    @IBOutlet var lblLevel1: UILabel!
    @IBOutlet var lblLevel2: UILabel!
    @IBOutlet var lblLevel3: UILabel!
    @IBOutlet var lblLevel4: UILabel!
    @IBOutlet var lblLevel5: UILabel!
    @IBOutlet var btnLevel1: UIButton!
    @IBOutlet var btnLevel2: UIButton!
    @IBOutlet var btnLevel3: UIButton!
    @IBOutlet var btnLevel4: UIButton!
    @IBOutlet var btnLevel5: UIButton!

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let unlockedLevel = USER.unlockedLevel
        
        btnLevel1.enabled = false
        btnLevel2.enabled = false
        btnLevel3.enabled = false
        btnLevel4.enabled = false
        btnLevel5.enabled = false
        
        if unlockedLevel >= 1 {
            
            lblLevel1.text = ""
            btnLevel1.enabled = true
            
            if unlockedLevel >= 2 {
                
                lblLevel2.text = ""
                btnLevel2.enabled = true
                
                if unlockedLevel >= 3 {
                    
                    lblLevel3.text = ""
                    btnLevel3.enabled = true
                    
                    if unlockedLevel >= 4 {
                        
                        lblLevel4.text = ""
                        btnLevel4.enabled = true
                        
                        if unlockedLevel == 5 {
                            
                            lblLevel5.text = ""
                            btnLevel5.enabled = true
                            
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