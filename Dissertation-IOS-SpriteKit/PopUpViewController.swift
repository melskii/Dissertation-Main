//
//  File.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 08/04/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    var message: NSString!
    var logoImg: UIImageView! = UIImageView()
    
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet var popUpView: UIView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        self.popUpView.layer.cornerRadius = 8
        self.popUpView.layer.shadowOpacity = 0.7
        self.popUpView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        }
    
        func showInView(aView: UIView!, withImage image : UIImage!, withMessage message: String!, animated: Bool)
        {
            aView.addSubview(self.view)
            logoImg!.image = image
            self.lblMessage!.text = message
            if animated
            {
                self.showAnimate()
            }
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

        func removeAnimate()
        {
            UIView.animateWithDuration(0.25, animations: {
                self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
                self.view.alpha = 0.0;
                }, completion:{(finished : Bool)  in
                    if (finished)
                    {
                        self.view.removeFromSuperview()
                    }
            });
        }

        @IBAction func closePopup(sender: AnyObject) {
            self.removeAnimate()
        }
    
}
