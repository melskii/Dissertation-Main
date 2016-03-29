//
//  HomeScene.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 17/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import SpriteKit

class HomeScene: SKScene, SKPhysicsContactDelegate, UIGestureRecognizerDelegate {
    
    var width, height: CGFloat!
    
    override func didMoveToView(view: SKView) {
        
        super.didMoveToView(view)
        
        self.name = "HomeScene"
        
        self.backgroundColor = UIColor.whiteColor()
        self.width = frame.size.width
        self.height = frame.size.height

        
        addChild(setupHome())

        
       
    }
    
    
    /*
    (0, height * 0.5) width = _width | height = _height * 0.5
    */
    func setupHome() -> SKSpriteNode {
        
        let body = SKSpriteNode(imageNamed: "outBckground")
        body.size = CGSize(width: self.width, height: self.height)
        body.position = CGPoint(x: (body.size.width * 0.5), y: (body.size.height * 0.5))
        body.name = "outputBackground"
        
        
        return body
        
    }
    
}