//
//  FeedbackViewController.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 09/04/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import UIKit


class FeedbackViewController: UIViewController {
    
    var feedbackView: FeedbackView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.feedbackView = self.view as! FeedbackView

     
    }
    
    func showInView(parent: UIView!, scene: GameScene, type: FeedbackType)
    {
        if self.viewIfLoaded == nil {
            
            loadView()
            
            self.feedbackView = self.view as! FeedbackView
            
        }
        
        feedbackView.setupView(parent, scene: scene, type: type)
        parent.addSubview(feedbackView)

        self.showAnimate()

    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
 
    

    
    
    
}
