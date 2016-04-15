//
//  FeedbackView.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 09/04/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import UIKit
import AVFoundation

class FeedbackView: UIView, UIGestureRecognizerDelegate {
 
    @IBOutlet var popUpView: UIView!
 
    @IBOutlet weak var btnNextLevel: UIButton!
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var imgStars: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imgDetail: UIImageView!
    @IBOutlet weak var lblComplete: UILabel!
    @IBOutlet weak var lblBest: UILabel!
    
    private var parent: UIView!
    private var scene: GameScene!
    private var type: FeedbackType!
    
    private var soundEffects: AVAudioPlayer!
    private var counter: Int = 0
    
    
    var delegate: FeedbackDelegate?
    
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
    
    override func awakeFromNib() {
 
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        self.popUpView.layer.cornerRadius = 8
        self.popUpView.layer.shadowOpacity = 0.7
        self.popUpView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FeedbackView.dismissFeedback))
        tap.delegate = self
        self.addGestureRecognizer(tap)
  
        
        
        

    }
    
    
    func setupView(parent: UIView, scene: GameScene, type: FeedbackType)
    {
        self.scene = scene
        self.scene.view?.scene?.paused = true
        
        self.parent = parent
        self.scene = scene
        self.type = type
      
        setBasedOnFeedbackType()

    }
    
    private func setBasedOnFeedbackType() {
        
        
        if type == FeedbackType.LevelHelp {
            
            
            levelHelp()
 
            
        }
        
        else if type == FeedbackType.InvalidSyntax {
            
            imgIcon.image = UIImage(named: "Code_Error")
            
            if let secondBeep = self.setupAudioPlayerWithFile("error2", type:"wav") {
                self.soundEffects = secondBeep
            }
            
            
            
            let feedback = SyntaxFeedbackString[Int(arc4random_uniform(3))]
            let extra: String = (feedback.name ? " \(USER.getUsersName()!)" : "")
            lblTitle.text = "\(feedback.feedback)\(extra)!"
            
            imgDetail.image = UIImage(named: "level3-1")
            
            
            
            
            soundEffects?.volume = 3
             soundEffects.rate = 2.0
            soundEffects.play()
            
            
            
        }
        
        else if type == FeedbackType.InvalidProgram {
            
            imgIcon.image = UIImage(named: "Program_Error")
            
  
            if let secondBeep = self.setupAudioPlayerWithFile("error2", type:"wav") {
                self.soundEffects = secondBeep
            }
            
            let feedback = CodeFeedbackString[Int(arc4random_uniform(3))]
            let extra: String = (feedback.name ? " \(USER.getUsersName()!)" : "")
            lblTitle.text = "\(feedback.feedback)\(extra)!"
            
            if LEVEL._mainimg != nil {
                imgDetail.image = LEVEL._mainimg!
            }
            
            soundEffects?.volume = 3
             soundEffects.rate = 2.0
            soundEffects.play()
        }
        
        else if type == FeedbackType.LevelComplete {
            
            levelComplete()
        }
        
        
    }
    
    func levelHelp () {
        
        btnOK.setImage(UIImage(named: "Next_Button"), forState: UIControlState.Normal)
        
        imgIcon.image = UIImage(named: "Info_Program")

        lblTitle.text = "Level \(_LEVEL)"
        
        
        updateImageDetail()
    }
    
    @IBAction func updateImageDetail () {
        
        if type == FeedbackType.LevelHelp {
            
            if counter < LEVEL._description {
                
                imgDetail.image = UIImage(named: "level\(_LEVEL)-\(counter)")
                counter += 1
                
                if counter == LEVEL._description {
                    
                    btnOK.setImage(UIImage(named: "btnOK"), forState: UIControlState.Normal)
                    
                }
            }
            else {
                
                dismissFeedback()

                
            }
        }
        else {
            
            dismissFeedback()
        }
        
    }
    
    func levelComplete() {
        
        imgDetail.hidden = true
        
        lblComplete.hidden = false
        lblBest.hidden = false
        
        lblTitle.text = "Level Complete"
        
        let name: String! = (USER.getUsersName() == "" ? "" : "\(USER.getUsersName()!) ")
        
        lblBest.text = "\(name!)You're the best!"
        
        imgIcon.image = UIImage(named: "Level_Complete")
        btnOK.hidden = true
        btnNextLevel.hidden = false
        
        
        
        imgStars.hidden = false
        let stars = USER.getRewardsStar(_LEVEL)
        imgStars.image = UIImage(named: "star\(String(USER.getRewardsStar(_LEVEL)))")
        
        if (stars >= 1) {
            
            if let beep = self.setupAudioPlayerWithFile("level-up-03", type:"wav") {
                self.soundEffects = beep
            }
            
            
            soundEffects?.volume = 1
            soundEffects.rate = 4.0
            soundEffects.play()
            
            sleep(1)
            
            if (stars >= 2) {
                
                if let beep = self.setupAudioPlayerWithFile("level-up-01", type:"wav") {
                    self.soundEffects = beep
                }
                
                
                soundEffects?.volume = 1
                soundEffects.rate = 4.0
                soundEffects.play()
                
                sleep(1)
                
                if (stars >= 3) {
                    
                    if let beep = self.setupAudioPlayerWithFile("level-up-02", type:"wav") {
                        self.soundEffects = beep
                    }
                    
                    
                    soundEffects?.volume = 1
                    soundEffects.rate = 4.0
                    soundEffects.play()
                    
                    
                    
                    
                }
                
                
                
                
            }
            
            
            
            
        }
        
        
        if MAXLEVELS == _LEVEL {
            
            
            btnNextLevel.setTitle("HOME", forState: UIControlState.Normal)
            
        }
    }
    
    
    @IBAction func test() {
     
//        lblMessage.text = "Changed"
        dismissFeedback()
        
    }
    
    func removeAnimate()
    {
        UIView.animateWithDuration(0.15, animations: {
            self.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.removeFromSuperview()
                }
        });
    }
    
    func dismissFeedback () {

        self.scene.view?.scene?.paused = false
        self.removeAnimate()
        self.imgDetail = nil
        
        
    }

    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        if type != FeedbackType.LevelComplete {
      
            if (touch.view == popUpView)
            {
                return false
            }
    
            return true
        }
        
        return false
    }
    
    @IBAction func presentNextLevel() {
        
        if delegate != nil {
            self.delegate?.presentNextLevel()
        }
        
    }
    
    
}
