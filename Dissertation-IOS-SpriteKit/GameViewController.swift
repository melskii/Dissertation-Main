//
//  GameViewController.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 21/02/2016.
//  Copyright (c) 2016 Mel Schatynski. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation



class GameViewController: UIViewController, GameDelegate, UIGestureRecognizerDelegate, UICollectionViewDelegate, FeedbackDelegate {
    
    @IBOutlet weak var skview: SKView!
    @IBOutlet weak var gameContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnRedo: UIButton!
    @IBOutlet weak var btnUndo: UIButton!
    @IBOutlet weak var lblName: UILabel!
    
    var scene: GameScene!
    var gameView: SKView!

    var audio: Bool = true
    
    //Variables to delete Block from UICollectionView
    var deleteCell: UICollectionViewCell?
    var deleteBlock: Bool = false
    
    var timer = NSTimer()
    var binaryCount = 0b0000
    
    var animation: Bool = false
    
    
    var soundEffects: AVAudioPlayer!
    var playTune: AVAudioPlayer!
    
    private var program: [Block] = []
    
    private var undo: Bool = true //set to false if it's redo - relates to preliminary
    private var preliminary: [Block] = []
    
    
    private var gesture: UILongPressGestureRecognizer!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
     
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        
        gesture = UILongPressGestureRecognizer(target: self, action: "handleLongGesture:")
        
        gesture.minimumPressDuration = 0.0
        gesture.delaysTouchesBegan = true
        gesture.delegate = self
        self.collectionView.addGestureRecognizer(gesture)

        
        skview = view as! SKView
        skview.multipleTouchEnabled = false
        
        setupDebugTools()
      
        skview.ignoresSiblingOrder = false
        
        scene = GameScene(size: skview.bounds.size)
        scene.scaleMode = .AspectFit
        
        scene.gameSceneDelegate = self
        
        skview.presentScene(scene)
        
        self.showLevelHelp()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(GameViewController.countUp), userInfo: nil, repeats: true)
        
        
        btnPlay.setImage(UIImage(named: "Play_Program_Invalid"), forState: UIControlState.Disabled)
        
        USER.resetAttempts() //Resets the attempts for the Rewards
       
        setUserLabel()
        
        
    }
    
    @IBAction func showLevelHelp() {
        
        self.showFeedbackView(FeedbackType.LevelHelp)
        
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
        
        resetUndoFlag()
        
        program.append(newblock)
        self.collectionView?.reloadData()
        
        
    }
    
    
    @IBAction func stopTouchDown(sender: AnyObject) {
        
        if !(btnPlay.enabled){
            
            playTune.stop()
            LEVEL.stopAnimation()
            btnPlay.enabled = true
            self.animation = false
        }
        
    }
    
    @IBAction func playTouchDown(sender: AnyObject) {
        
        
        if !(animation) {
        
            USER.appendAttempts()
            
            if let tune = self.setupAudioPlayerWithFile("tune", type:"wav") {
                self.playTune = tune
            }
            
            
            if (!program.isEmpty && self.validProgramFlow()) {

                let valid = LEVEL.validProgram(program)

                if valid == true {
                    
                    self.stopCount(true)
                    USER.setProgramFlow(self.program, type: FeedbackType.LevelComplete)
//                    self.stopCount(true)
                    
                    if playTune.playing {
                        playTune.stop()
                    }
                
                    
                }
                else
                {
                    
                    USER.setProgramFlow(self.program, type: FeedbackType.InvalidProgram)
                    
                   
                 
                }
             
                
                btnPlay.enabled = false
//                playTune.playAtTime(0)
                
               
                
                playTune.numberOfLoops = -1
                playTune.play()
                
                
                LEVEL.runAnimation(valid) {
                    (animationComplete: Bool) in
                    
                    self.animation = true
                
                    if animationComplete == true {
                    
                        if valid == true {
                            
                          
                
                            self.playTune.stop()
                            self.showFeedbackView(FeedbackType.LevelComplete)
                            
                        }
                        else {
                          
                            self.playTune.stop()
                            self.showFeedbackView(FeedbackType.InvalidProgram)
                
                        }
                        
                        self.playTune.stop()
                        self.btnPlay.enabled = true
                        
                        self.animation = false

                    }
                }
            }


            else {
                
                
                
                    showFeedbackView(FeedbackType.InvalidSyntax)
            }
        }
        
        
    }
    
    func presentNextLevel() {
        
        self.scene.removeAllChildren()
        self.scene.removeAllActions()
        self.scene = nil
        self.gameView = nil
        
        if _LEVEL == MAXLEVELS
        {
            
            
            self.performSegueWithIdentifier("showHomeSegue", sender: nil)
        }
        
        else {
            
            _LEVEL++
            LEVEL = Level(level: _LEVEL)
            
            var next: GameViewController
            
            let controllerID = "GameViewController"
            let storyboardName = "Main"
            let storyboard = UIStoryboard(name: storyboardName, bundle:  NSBundle.mainBundle())
            
            next = ((storyboard.instantiateViewControllerWithIdentifier(controllerID) as UIViewController!) as? GameViewController)!
            
            self.presentViewController(next, animated: true, completion: nil)
            
            
        }
        
        
        
        
  
        
        
     
        
    }
    
    func validProgramFlow() -> Bool {
        
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
            USER.setProgramFlow(program, type: FeedbackType.InvalidSyntax)
        }
        
        return valid
        
        
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
//            
            if selectedIndexPath.item >= LEVEL._lockedBlocks {
                
                collectionView.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath)
                deleteCell = collectionView.cellForItemAtIndexPath(selectedIndexPath)
            }
            
            
        case UIGestureRecognizerState.Changed:
            
            
            let location = gesture.locationInView(gesture.view!)
           
            
            if (deleteCell != nil && (location.x >= 655 && location.y >= 283))
            {
                             deleteBlock = true
                scene.animateBin()
                
                
                if let crunch = self.setupAudioPlayerWithFile("crunch", type:"wav") {
                    self.soundEffects = crunch
                }
                
                
                soundEffects?.volume = 1
                soundEffects.rate = 2.0
                soundEffects.play()
                
                
                
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
            
            resetUndoFlag()
            
            let path = collectionView.indexPathForCell(deleteCell!)
            
            let block = program[path!.row]
            
            program.removeAtIndex(path!.row)
            collectionView.deleteItemsAtIndexPaths([path!])
        }
        
    }
    
    @IBAction func btnUndoTouchDown() {
        
        let i = LEVEL._lockedBlocks == 0 ? -1 : LEVEL._lockedBlocks
        
        if undo && program.count > i {
            
            let hold = program
            if preliminary.count > 0 {
                program = self.preliminary
            }
            else {
                program = []
            }
            
            
            self.collectionView?.reloadData()
            
            undo = !undo
            
            self.preliminary = hold
         
        }

    }
    
    @IBAction func btnRedoTouchDown(sender: AnyObject) {
        
        if !undo && preliminary.count > 0  {
            
            let hold = program
            program = self.preliminary
            self.collectionView?.reloadData()
            
            undo = !undo
            
            self.preliminary = hold
            
        }


        
        
    }
    @IBAction func btnHomeTouchDown(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Do you want to leave the level?", message: "", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .Cancel) { (action:UIAlertAction!) in
            
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Yes", style: .Default) { (action:UIAlertAction!) in
            
            self.stopCount(false)
            LEVEL = nil
            self.scene.removeAllChildren()
            self.scene.removeAllActions()
            self.scene = nil
            self.gameView = nil
            
            self.performSegueWithIdentifier("showHomeSegue", sender: nil)
            
            

        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true, completion:nil)
        
        
    }
    
    private func resetUndoFlag() {
        
        self.preliminary = program
        undo = true
        

    }
    
    private func showFeedbackView (type: FeedbackType) {
        
        
        
        var feedback: FeedbackViewController
        
        let controllerID = "FeedbackViewController"
        let storyboardName = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle:  NSBundle.mainBundle())
        
        
        
        feedback = ((storyboard.instantiateViewControllerWithIdentifier(controllerID) as! UIViewController!) as? FeedbackViewController)!
        
        feedback.showInView(self.view, scene: scene, type: type)
        
        feedback.feedbackView.delegate = self
        
        
        
        
    }
    
    func setUserLabel() {
        
        lblName.hidden = true
        
        if USER.getUsersName() != "" {
            
            lblName.hidden = false
            lblName.text = "Hi \(USER.getUsersName()!)!"
            
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
    
        resetUndoFlag()
        
        let temp = program.removeAtIndex(sourceIndexPath.item)
        program.insert(temp, atIndex: destinationIndexPath.item)

        
//        if (destinationIndexPath.item <= LEVEL._lockedBlocks){
//      
//            btnUndoTouchDown()
//            self.collectionView?.reloadData()
//            
//        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        
        return CGSizeMake (70, 70)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
        
        var audioPlayer:AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        
        return audioPlayer
    }
    
    
}

protocol GameDelegate {
    
    func appendProgramFlowBlock (newblock: Block)

    
}

protocol FeedbackDelegate {
    func presentNextLevel()
}





