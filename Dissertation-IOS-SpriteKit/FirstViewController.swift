//
//  File.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 08/04/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var popViewController: PopUpViewController!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    @IBAction func showSecondViewController() {
        
        let viewControllerStoryboardId = "popUpView"
        let storyboardName = "Test"
        let storyboard = UIStoryboard(name: storyboardName, bundle: NSBundle.mainBundle())
        self.popViewController = (storyboard.instantiateViewControllerWithIdentifier(viewControllerStoryboardId) as UIViewController!) as? PopUpViewController
        
        
        
//        self.popViewController = PopUpViewController(nibName: "popUpView", bundle: nil)
        self.popViewController.title = "This is a popup view"
        self.popViewController.showInView(self.view, withImage: UIImage(named: "typpzDemo"), withMessage: "You just triggered a great popup window", animated: true)
        
//        self.performSegueWithIdentifier("idFirstSegue", sender: self)
    }
    
}
