//
//  UserViewController.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 21/02/2016.
//  Copyright (c) 2016 Mel Schatynski. All rights reserved.
//

import UIKit
import SpriteKit

protocol UserDelegate {
    
    func setUserDetals ()
    
}

class UserViewController: UIViewController {
    
    var scene: UserScene!
    var userDelegate: UserDelegate?
    
    @IBOutlet weak var skview: SKView!
    

    override func loadView() {
        
        super.loadView()
        
        print("init user view")
    }
  
//    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        
        
        
    }

    @IBAction func btnOKTouchDown(sender: AnyObject) {
        
        returnToPreviousController()
        
    }
    
    @IBAction func btCancelTouchDown(sender: AnyObject) {
        
        returnToPreviousController()
    }
    
    func returnToPreviousController() {
        
        self.dismissViewControllerAnimated(true, completion: {});
        

    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
