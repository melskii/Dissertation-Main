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
    
    var scene: UserScene!
    var userDelegate: UserDelegate?
    var gameSceneDelegate: GameSceneDelegate?
    
    @IBOutlet weak var skview: SKView!

    override func loadView() {
        
        super.loadView()
        
        self.view = SKView(frame: self.view.frame)//[[SKView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    }
  
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        self.view.backgroundColor = UIColor.redColor()
        
        skview = view as! SKView
        skview.multipleTouchEnabled = false
        
        skview.showsFPS = true
        skview.showsNodeCount = true
        //skView.showsPhysics = true
        skview.showsDrawCount = true
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skview.ignoresSiblingOrder = false
        
        //initialise first Scene
        scene = UserScene(size: skview.bounds.size)
        scene.scaleMode = .AspectFill
        
        //present the scene
        scene.gameSceneDelegate = self.gameSceneDelegate
        skview.presentScene(scene)
        
        
    }
    
    func setupLogin () {
        
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Update the users details at this point
        self.userDelegate?.setUserDetals()
        
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
