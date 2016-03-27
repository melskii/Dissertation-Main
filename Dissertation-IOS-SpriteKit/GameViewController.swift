//
//  GameViewController.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 21/02/2016.
//  Copyright (c) 2016 Mel Schatynski. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, ControlsSceneDelegate, UserDelegate {
    
    var gameScene: SKScene!
    var gameView: SKView!
    var menuScene: ControlsScene!
    var menuView: SKView!
    var user: UserModel!
    var userView: UserViewController!
    var audio: Bool = true
    
    let _MENUHEIGHT: CGFloat = 56
    var _GAMEHEIGHT: CGFloat!
    
    @IBOutlet weak var skview: SKView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        _GAMEHEIGHT = self.view!.frame.height - _MENUHEIGHT
        
        self.gameView  = SKView(frame: CGRectMake(0, _MENUHEIGHT, self.view!.frame.width, _GAMEHEIGHT))
        self.menuView = SKView(frame: CGRectMake(0, 0, self.view!.frame.width, _MENUHEIGHT))

        if let scene = ControlsScene(size: menuView.bounds.size) as? ControlsScene {
            
            let skView = self.menuView as! SKView
            self.menuScene = scene
            
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .AspectFill
            
            self.view!.addSubview(skView)
            self.view!.bringSubviewToFront(skView)
            
            skView.allowsTransparency = true
            scene.backgroundColor = UIColor.clearColor()
            scene.controlsSceneDelegate = self
            skView.presentScene(scene)
        }
        
        
        
        if let scene = GameScene(size: gameView.bounds.size) as? GameScene {
           
//            let skView = self.gameView as! SKView
            self.gameScene = scene
            
            gameView.ignoresSiblingOrder = true
            scene.scaleMode = .AspectFill
            
            self.view!.addSubview(gameView)
            self.view!.sendSubviewToBack(gameView)
            
            gameView.allowsTransparency = true
            scene.backgroundColor = UIColor.clearColor()
            gameView.presentScene(scene)
        }
        
        print("initial: \(menuScene)")
        






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
        GameSceneDelegate methods
   
        Scene Transistions 
    */
    func homeScene() {

        gameView.removeFromSuperview()
        self.view!.addSubview(gameView)
        self.view!.sendSubviewToBack(gameView)

        //unable to add transistion with subview - http://stackoverflow.com/questions/33245364/spritekit-skview-no-longer-transitions-between-scenes-in-ios-9
        let transition = SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 0.35)
        
        if gameScene is HomeScene {
            
            if let game = GameScene(size: gameView.bounds.size) as? GameScene {
                game.scaleMode = SKSceneScaleMode.AspectFill
                self.gameScene = game
                self.gameView.presentScene(game)
            }
           
        }
        
        else {
            
            if let home = HomeScene(size: gameView.bounds.size) as? HomeScene {
                home.scaleMode = SKSceneScaleMode.AspectFill
                self.gameScene = home
                self.gameView.presentScene(home)
            }

        }
    }
    
    func userScene() {
        
        gameScene.paused = true;
        
        let storyboard = UIStoryboard(name: "User", bundle: NSBundle.mainBundle())

        let vc = storyboard.instantiateViewControllerWithIdentifier("userController") as! UIViewController
        
        self.presentViewController(vc, animated: true, completion: nil)
        
        
        print("hit child view")

        
        
        
    
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
