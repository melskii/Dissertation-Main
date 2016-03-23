//
//  GameViewController.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 21/02/2016.
//  Copyright (c) 2016 Mel Schatynski. All rights reserved.
//

import UIKit
import SpriteKit

class UserViewController: UIViewController {
    
    var scene: UserScene!
    var user: UserProfile!
    //    var scene: HomeScene!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        //skView.showsPhysics = true
        skView.showsDrawCount = true
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = false
        
        
        //initialise userprofile
        user = UserProfile(participant: 0)
        
        //initialise first Scene
        scene = UserScene(size: skView.bounds.size)
          scene.scaleMode = .AspectFill
        
        //present the scene
        skView.presentScene(scene)
        
        
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
