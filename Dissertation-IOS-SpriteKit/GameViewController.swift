//
//  GameViewController.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 21/02/2016.
//  Copyright (c) 2016 Mel Schatynski. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, UserDelegate {
    
    var scene: GameScene!
    
    var gameScene: SKScene!
    var gameView: SKView!

    var user: UserModel!
    var userView: UserViewController!
    var audio: Bool = true
    
    let _MENUHEIGHT: CGFloat = 56
    var _GAMEHEIGHT: CGFloat!
    
    @IBOutlet weak var skview: SKView!
    @IBOutlet weak var gameContainer: UIView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        _GAMEHEIGHT = self.view!.frame.height - _MENUHEIGHT
        
        gameView  = SKView(frame: CGRectMake(0, _MENUHEIGHT, self.view!.frame.width, _GAMEHEIGHT))
     
        
//        if let scene = GameScene(size: gameView.bounds.size) as? GameScene {
//            
//            let skview = self.view as! SKView
//            self.gameScene = scene
//            
//            gameView.ignoresSiblingOrder = true
//            scene.scaleMode = .AspectFill
//            
////            self.view!.addSubview(gameView)
////            self.view!.bringSubviewToFront(gameView)
//            
////            gameView.allowsTransparency = true
//            scene.backgroundColor = UIColor.clearColor()
//            gameView.presentScene(scene)
//            
//        }

        
        skview = view as! SKView
        skview.multipleTouchEnabled = false
        
        setupDebugTools()
      
        skview.ignoresSiblingOrder = false
        
        scene = GameScene(size: skview.bounds.size)
        scene.scaleMode = .AspectFit
        
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
        UserDelegate methods
    */
    
    func setUserDetals() {
        
    }

    
 
    
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
    
    
    
    
    /*  override func viewDidLoad() {
    
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
    
    //present the scene
    //        skview.presentScene(scene)
    
    
    menuscene = MenuScene(size: skview.bounds.size)
    menuscene.scaleMode = .AspectFill
    
    
    menuscene.gameSceneDelegate = self
    
    //present the scene
    skview.presentScene(menuscene)
    
    
    
    }*/
    
    
}
