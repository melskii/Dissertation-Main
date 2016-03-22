//
//  HomeScene.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 17/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import SpriteKit

class HomeScene: MenuScene {
    
 
    override func didMoveToView(view: SKView) {
        
        super.didMoveToView(view)
        
        self.name = "HomeScene"
        
       
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        /* Called when a touch begins */
        let touch = touches
        let location = touch.first!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        
        
        menuNodeForTouch(location, node:node)
        
    }

    

}