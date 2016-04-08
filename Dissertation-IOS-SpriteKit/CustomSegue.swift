//
//  CustomSegue.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 08/04/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import UIKit


class CustomSegue: UIStoryboardSegue {
    
    
    override func perform() {
        var a = self.sourceViewController.view as UIView!
        var b = self.destinationViewController.view as UIView!
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width   
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        b.frame = CGRectMake(0.0, screenHeight, screenWidth-50, screenHeight-50)
        
        
        // Access the app's key window and insert the destination view above the current (source) one.
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(b, aboveSubview: a)
        
        // Animate the transition.
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            a.alpha = 0.4
            b.alpha = 1.0
            
            }) { (Finished) -> Void in
                
                self.sourceViewController.presentViewController(self.destinationViewController as UIViewController,
                    animated: false,
                    completion: nil)
                
        }

    }
    
}