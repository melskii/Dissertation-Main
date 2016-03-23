//
//  UserScene.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 22/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import SpriteKit

class UserScene: MenuScene {
    

    override func didMoveToView(view: SKView) {
        
        super.didMoveToView(view)
        
        self.name = "UserScene"
        
        addChild(setupUserScreen())
              
        
        
    }
    
    /*
    
    */
    func setupUserScreen() -> SKSpriteNode {
        
        let body = SKSpriteNode(imageNamed: "outBckground")
        body.size = CGSize(width: _width, height: _height)
        body.position = CGPoint(x: (body.size.width * 0.5), y: (body.size.height * 0.5))

        body.name = "userBackground"
        
        
        return body
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        /* Called when a touch begins */
        let touch = touches
        let location = touch.first!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        
        
        menuNodeForTouch(location, node:node)
        
    }

}
    