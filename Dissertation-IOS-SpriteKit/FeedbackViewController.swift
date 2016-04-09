//
//  FeedbackViewController.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 09/04/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import UIKit


class FeedbackViewController: UIViewController {
    
    var vw: FeedbackView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.vw = self.view as! FeedbackView

     
    }
    
    //func showInView(aView: UIView!, withImage image : UIImage!, withMessage message: String!, animated: Bool)
    func showInView(parent: UIView!, scene: GameScene, type: FeedbackType)
    {
        if self.viewIfLoaded == nil {
            
            loadView()
            
            self.vw = self.view as! FeedbackView
            
        }
        
        vw.setupView(parent, scene: scene, type: type)
        parent.addSubview(vw)

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
