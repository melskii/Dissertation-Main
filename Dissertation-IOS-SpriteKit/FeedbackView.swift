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
    
    var parent: UIView!
    var scene: GameScene!
    var type: FeedbackType!
    
    @IBOutlet var popUpView: UIView!
 
    @IBOutlet weak var btnNextLevel: UIButton!
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var imgStars: UIImageView!
    
    var soundEffects: AVAudioPlayer!
    
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
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("dismissFeedback"))
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
            
            imgIcon.image = UIImage(named: "Info_Program")
            
            
            if let secondBeep = self.setupAudioPlayerWithFile("SecondBeep", type:"wav") {
                self.soundEffects = secondBeep
            }
            
            
            soundEffects?.volume = 1
            soundEffects.play()
            
        }
        
        else if type == FeedbackType.InvalidSyntax {
            
            imgIcon.image = UIImage(named: "Code_Error")
            
            
            
        }
        
        else if type == FeedbackType.InvalidProgram {
            
            imgIcon.image = UIImage(named: "Program_Error")
        }
        
        else if type == FeedbackType.LevelComplete {
            
            imgIcon.image = UIImage(named: "Level_Complete")
            btnOK.hidden = true
            btnNextLevel.hidden = false
            
            imgStars.hidden = false
            imgStars.image = UIImage(named: "star\(String(USER.getRewardsStar(_LEVEL)))")
            
            
            if MAXLEVELS == _LEVEL {
                
                
                btnNextLevel.setTitle("HOME", forState: UIControlState.Normal)
                
            }
        }
        
        
    }
    
    
    @IBAction func test() {
        
        print("hit here")
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
