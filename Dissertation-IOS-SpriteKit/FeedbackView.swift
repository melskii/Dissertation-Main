//
//  FeedbackView.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 09/04/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import UIKit

class FeedbackView: UIView, UIGestureRecognizerDelegate {
    
    var parent: UIView!
    var scene: GameScene!
    var type: FeedbackType!
    
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnNextLevel: UIButton!
    @IBOutlet weak var btnOK: UIButton!
    
    var delegate: FeedbackDelegate?
    
    func setupView(parent: UIView, scene: GameScene, type: FeedbackType)
    {
        
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        self.popUpView.layer.cornerRadius = 8
        self.popUpView.layer.shadowOpacity = 0.7
        self.popUpView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        self.scene = scene
        self.scene.view?.scene?.paused = true
        
        self.parent = parent
        self.scene = scene
        self.type = type
        
        self.lblMessage.text = self.type.rawValue
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("dismissFeedback"))
        tap.delegate = self
        self.addGestureRecognizer(tap)
        
        if type != FeedbackType.LevelComplete {
            
            btnNextLevel.hidden = true
        }
        else {
            btnOK.hidden = true
            
            if MAXLEVELS == _LEVEL {
                
                lblMessage.text = "Final Level!"
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
