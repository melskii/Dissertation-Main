//
//  SubGameViewController.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 29/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import UIKit
import SpriteKit

class GameController: UIViewController {
    
    
    var gameScene: SKScene!
    
    /*
        TO DELETE BUT MAY NEED IN THE FUTURE

    */
 
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
  
  
        
        
    }
    
    
    /*
    GameSceneDelegate methods
    
    
    Code just here to re-use in the future!
    
    Scene Transistions
    */
    //    func homeScene() {
    //
    //        gameView.removeFromSuperview()
    //        self.view!.addSubview(gameView)
    //        self.view!.sendSubviewToBack(gameView)
    //
    //        //unable to add transistion with subview - http://stackoverflow.com/questions/33245364/spritekit-skview-no-longer-transitions-between-scenes-in-ios-9
    //        let transition = SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 0.35)
    //
    //        if gameScene is HomeScene {
    //
    //            if let game = GameScene(size: gameView.bounds.size) as? GameScene {
    //                game.scaleMode = SKSceneScaleMode.AspectFill
    //                self.gameScene = game
    //                self.gameView.presentScene(game)
    //            }
    //
    //        }
    //
    //        else {
    //
    //            if let home = HomeScene(size: gameView.bounds.size) as? HomeScene {
    //                home.scaleMode = SKSceneScaleMode.AspectFill
    //                self.gameScene = home
    //                self.gameView.presentScene(home)
    //            }
    //
    //        }
    //    }
    //
    //    func userScene() {
    //
    //        gameScene.paused = true;
    //
    //        let storyboard = UIStoryboard(name: "User", bundle: NSBundle.mainBundle())
    //
    //        let vc = storyboard.instantiateViewControllerWithIdentifier("userController") as! UIViewController
    //
    //        self.presentViewController(vc, animated: true, completion: nil)
    //
    //
    //        print("hit child view")
    //
    //
    //
    //
    //
    //    }
    
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

    

}