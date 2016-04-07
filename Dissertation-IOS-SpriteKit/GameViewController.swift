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
    var gameView: SKView!

    var audio: Bool = true
    
    //Variables to delete Block from UICollectionView
    var deleteCell: UICollectionViewCell?
    var deleteBlock: Bool = false
    
    var timer = NSTimer()
    var binaryCount = 0b0000
    
    
    @IBOutlet weak var skview: SKView!
    @IBOutlet weak var gameContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var program: [Block] = []
    
    
    private var lPG: UILongPressGestureRecognizer!

    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        
        lPG = UILongPressGestureRecognizer(target: self, action: "handleLongGesture:")
        
        lPG.minimumPressDuration = 0.0
        lPG.delaysTouchesBegan = true
        lPG.delegate = self
        self.collectionView.addGestureRecognizer(lPG)
    
    
//        GAME_HEIGHT = self.view!.frame.height - MENU_HEIGHT
        
      
        
        skview = view as! SKView
        skview.multipleTouchEnabled = false
        
        setupDebugTools()
      
        skview.ignoresSiblingOrder = false
        
        scene = GameScene(size: skview.bounds.size)
        scene.scaleMode = .AspectFit
        
        scene.gameSceneDelegate = self
        
        skview.presentScene(scene)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
        
        USER.resetAttempts() //Resets the attempts for the Rewards
        
    }
    
    func countUp() {
        
        binaryCount += 0b0001
        
        
    }
    
    func stopCount(complete: Bool) {
        
        
        
        timer.invalidate()

        
        if complete {
            let text = String(binaryCount, radix:2)
            let number = Int(strtoul(text, nil, 2))
            
            
            USER.appendTimeToComplete(number)
            
            print(number)
        }
        
        binaryCount = 0b0000
        
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
        
        
        program.append(newblock)
        
        self.collectionView?.reloadData()
        
        
    }
    
    
    
    @IBAction func playTouchDown(sender: AnyObject) {
        
        if (!program.isEmpty && validProgramFlow()) {
            
            if LEVEL.validProgram(program) {
                
                USER.setProgramFlow(program, type: nil)
                stopCount(true)
                print("valid")
//                _LEVEL++
            }
            
            else {
              
                USER.setProgramFlow(program, type: "Code")
                print("not valid")
                
                
            }
            
            
        }
        
        else {
            
            print("not valid")
        }
        
        USER.appendAttempts()
        
    }
    
    func validProgramFlow() -> Bool {
        
//        var array = [Block]()
        var valid = true
        var prev:Block = Block()
        var object:Object? = nil
        var index = 0
        
        
        for cell in program {
        
            
            
            if let block = cell as? Block {
            
                
                if index == 0 {
                    
                    valid = block is Play ? true : false
                    
                }
                
                else {
                    
                    if block is Object {
                        
                        prev = block
                        object = block as? Object
                        
                    }
                    
                    else if block is Action {
                        
                        if object == nil {
                            
                            valid = false
                            
                        }
                        
                        else {
                            
                            prev = block
                            
                        }
                    }
                    
                    else if block is Control {
                        
                        if !(prev is Action) {
                            
                            valid = false
                            
                        }
                        
                        else {
                            
                            prev = block
                            
                        }
                        
                    }
                    
                    else {
                        valid = false
                    }
                    
                }
                
                
                if valid == false {
                    break
                }
                
                    
                index++
    
                
            }
            
            
        }
        
        if prev is Object {
            
            valid = false
            
            
        }
        
        if valid == false {
            USER.setProgramFlow(program, type:  "Parse")
        }
        
        return valid
        
        
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
        
        return USER.getParticipantName()
        
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
            guard let selectedIndexPath = self.collectionView.indexPathForItemAtPoint(gesture.locationInView(self.collectionView))
            else {
                
                break
            }
            collectionView.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath)
            deleteCell = collectionView.cellForItemAtIndexPath(selectedIndexPath)
            
            
        case UIGestureRecognizerState.Changed:
            
            
            let location = gesture.locationInView(gesture.view!)
           
            
            if (deleteCell != nil && (location.x >= 655 && location.y >= 285))
            {
                print("out of bounds")
                
                deleteBlock = true
                scene.animateBin()
                
                
            }
            else {
                collectionView.updateInteractiveMovementTargetPosition(location)
            }
            
            
            
        case UIGestureRecognizerState.Ended:
      
            collectionView.endInteractiveMovement()
            
            if deleteBlock {
                
                removeCollectionCell()
                
                deleteBlock = false
                deleteCell = nil
            }
            
        default:
            
            collectionView.cancelInteractiveMovement()
            
        }
    }
    
    func removeCollectionCell() {
        
        if deleteCell != nil {
            
            let path = collectionView.indexPathForCell(deleteCell!)
            
            program.removeAtIndex(path!.row)
            collectionView.deleteItemsAtIndexPaths([path!])
        }
        
    }
    
    
    @IBAction func btnHomeTouchDown(sender: AnyObject) {
        
        stopCount(false)
        LEVEL = nil
        scene.removeAllChildren()
        scene.removeAllActions()
        scene = nil
        gameView = nil
        
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






