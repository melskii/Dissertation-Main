//
//  GameViewController.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 21/02/2016.
//  Copyright (c) 2016 Mel Schatynski. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, MenuSceneDelegate {
    
    var scene: LevelScene!
    var user: UserProfile!
    var audio: Bool = true
    
    @IBOutlet weak var skview: SKView!
//    var scene: HomeScene!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        
        skview = view as! SKView
        skview.multipleTouchEnabled = false
        
        skview.showsFPS = true
        skview.showsNodeCount = true
        //skView.showsPhysics = true
        skview.showsDrawCount = true
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skview.ignoresSiblingOrder = false

        
        //initialise userprofile
        user = UserProfile(participant: 0)

        //initialise first Scene
        scene = LevelScene(size: skview.bounds.size)
//        scene = HomeScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        //present the scene
        skview.presentScene(scene)
        
        scene.setParticipant(user)
        
        scene.menuSceneDelegate = self
        
        
        

    }
    
    func homeScene() {
        
        let nextScene = HomeScene(size: skview.bounds.size)
        nextScene.menuSceneDelegate = self
        
        let transition = SKTransition.crossFadeWithDuration(0.5)
        
        
        skview.presentScene(nextScene, transition: transition)

        
        print("initialise home")

    }
    
    func userScene() {
        
        let nextScene = UserScene(size: skview.bounds.size)
        nextScene.menuSceneDelegate = self
        
        let transition = SKTransition.crossFadeWithDuration(0.5)
    
        
        skview.presentScene(nextScene, transition: transition)

    
        print("initialise")

    }
    
    /*
        The following two classes determine if audio feedback is required or not.
        This is then passed to each scene.
    */
    func setAudioFeedback (audio: Bool)
    {
        self.audio = audio
    }
    
    func getAudioFeedback () -> Bool {
        
        return audio
    }
    
    
    
    func loadUserPage() {
        print("loaded user page")
    }


    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
