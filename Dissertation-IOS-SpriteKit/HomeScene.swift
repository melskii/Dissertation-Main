//
//  HomeScene.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 17/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import SpriteKit

class HomeScene: SKScene, SKPhysicsContactDelegate, UIGestureRecognizerDelegate {
    
    override func didMoveToView(view: SKView) {
        
        super.didMoveToView(view)
        
        self.name = "HomeScene"

        
        self.backgroundColor = UIColor.redColor()
    }
    
}