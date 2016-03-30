//
//  GameViewController.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 21/02/2016.
//  Copyright (c) 2016 Mel Schatynski. All rights reserved.
//

import UIKit
import SpriteKit



class GameViewController: UIViewController, UIGestureRecognizerDelegate, UICollectionViewDelegate, GameDelegate {
    
    var scene: GameScene!
    
    var gameScene: SKScene!
    var gameView: SKView!

    var user: UserModel!
    var userView: UserViewController!
    var audio: Bool = true
    
  
    var _GAMEHEIGHT: CGFloat!
    
    @IBOutlet weak var skview: SKView!
    @IBOutlet weak var gameContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var program: [Block] = []
    
    
    private var lPG: UILongPressGestureRecognizer!

    override func viewDidLoad() {
        
        super.viewDidLoad()
//        
//        for _ in 0...30 {
//            
//            program.append(Play())
//            
//        }
//        
//        print(program)
//        

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        
        lPG = UILongPressGestureRecognizer(target: self, action: "handleLongGesture:")
        
        lPG.minimumPressDuration = 0.0
        lPG.delaysTouchesBegan = true
        lPG.delegate = self
        self.collectionView.addGestureRecognizer(lPG)
    
    
        _GAMEHEIGHT = self.view!.frame.height - MENU_HEIGHT
        
        gameView  = SKView(frame: CGRectMake(0, MENU_HEIGHT, self.view!.frame.width, _GAMEHEIGHT))
     


        
        skview = view as! SKView
        skview.multipleTouchEnabled = false
        
        setupDebugTools()
      
        skview.ignoresSiblingOrder = false
        
        scene = GameScene(size: skview.bounds.size)
        scene.scaleMode = .AspectFit
        
        scene.gameSceneDelegate = self
        
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
        GameDelegate methods
    */
    
    func appendProgramFlowBlock(newblock: Block) {
        
        
        let index = program.count == 0 ? 0 : program.count - 1
 
        program.append(newblock)
        
        self.collectionView?.reloadData()
        
        
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
    
    
    /*
        Make the UICollectionView Re-Order
    */
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.Began:
            guard let selectedIndexPath = self.collectionView.indexPathForItemAtPoint(gesture.locationInView(self.collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath)
        case UIGestureRecognizerState.Changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.locationInView(gesture.view!))
        case UIGestureRecognizerState.Ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    
}


extension GameViewController: UICollectionViewDataSource {
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return program.count
    }
    

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("ProgramCell", forIndexPath: indexPath) as? ProgramCell
        {
            
            let b = program[indexPath.row]
            
            cell.configureCell(b)
            
            return cell
        }
            
        else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        let temp = program.removeAtIndex(sourceIndexPath.item)
        program.insert(temp, atIndex: destinationIndexPath.item)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        
        return CGSizeMake (70, 70)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

protocol GameDelegate {
    
    func appendProgramFlowBlock (newblock: Block)
    
}






