//
//  GameViewController.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 21/02/2016.
//  Copyright (c) 2016 Mel Schatynski. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, GameSceneDelegate, UserDelegate {
    
    var scene: LevelScene!
    var user: UserModel!
    var audio: Bool = true
    
    @IBOutlet weak var skview: SKView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        print("hello\(view)")
        
        skview = view as! SKView
        setupDebugTools()
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skview.ignoresSiblingOrder = false
        skview.multipleTouchEnabled = false

        
        //initialise userprofile
        user = UserModel()
        //initialise first Scene
        scene = LevelScene(size: skview.bounds.size)
        scene.scaleMode = .AspectFill
        
        scene.gameSceneDelegate = self
        
        //present the scene
        skview.presentScene(scene)


    }
    
    /* 
        Set up to be able to see what is happening on screen. Remove in final product
    */
    func setupDebugTools () {
        
        
        
        skview.showsFPS = true
        skview.showsNodeCount = true
        skview.showsPhysics = true
        skview.showsDrawCount = true
        
    }
    
    /*
        Login into the System
    */
    func loadUserPage() {
      
        
        let userViewController =  UserViewController()
     
        
        userViewController.userDelegate = self
        userViewController.gameSceneDelegate = self
        
        presentViewController(userViewController, animated: false, completion: nil)
        
        
    }
    
    /*
        UserDelegate methods
    */
    
    func setUserDetals() {
        
    }

    
    /*
        GameSceneDelegate methods
   
        Scene Transistions 
    */
    func homeScene() {
        
        let nextScene = HomeScene(size: skview.bounds.size)
        nextScene.gameSceneDelegate = self
        
        let transition = SKTransition.crossFadeWithDuration(0.5)
        
        
        skview.presentScene(nextScene, transition: transition)
        
        
        print("initialise home")
        
    }
    
    func userScene() {
        loadUserPage()
    }
    
//    func userScene() {
//        
//        let nextScene = UserScene(size: skview.bounds.size)
//        nextScene.gameSceneDelegate = self
//        
//        let transition = SKTransition.crossFadeWithDuration(0.5)
//        
//        
//        skview.presentScene(nextScene, transition: transition)
//        
//        
//        print("initialise")
//        
//    }
    
    /* 
        Variables within the Scenes
    */
    
    //To be used for the audio feedback
    func setAudioFeedback (audio: Bool)
    {
        self.audio = audio
    }
    
    func getAudioFeedback () -> Bool {
        
        
        return audio
    }
    
    //User information
    func getParticipantName () -> String? {
        
        return user.getParticipantName()
        
    }
    
    /*
        Change default IOS preferences 
    */
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
