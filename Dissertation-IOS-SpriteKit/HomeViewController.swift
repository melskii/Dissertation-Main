//
//  HomeViewController.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 29/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import UIKit
import SpriteKit
import Darwin

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var btnExit: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
     
        for family: String in UIFont.familyNames()
        {
            print("family: \(family)")
            for names: String in UIFont.fontNamesForFamilyName(family)
            {
                print("== \(names)")
            }
        }
        
    }
    
   
    /*
    Change default IOS preferences
    */
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    @IBAction func btnExitTouchDown() {
        
    
        exit(0)
        
    }
}