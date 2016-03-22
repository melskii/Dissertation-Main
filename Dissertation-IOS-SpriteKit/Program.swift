//
//  Program.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 25/02/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import Foundation
import SpriteKit

public class Program {
    
    var program: SKSpriteNode!
    var position: CGPoint!
    var name: String
    var id: Int
    
    public init(img: String, scale: CGFloat, id: Int) {
        
        self.name = "\(img)_\(id))"
        self.id = id
        
        program = ProgramSprite(imageNamed: img)
        
        program.physicsBody = SKPhysicsBody(rectangleOfSize: program.size)
        program.physicsBody?.affectedByGravity = false
        
        program.physicsBody?.friction = 0
    
        program.name  = name
        program.setScale(scale)
        
    }
    
    public func setPosition(position: CGPoint) {
    
        program.position = position
    
    }
}


public class ProgramSprite: SKSpriteNode {
    
  
    
    override public func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)


            //something about it being a child and a parent. Moving everything
            let parent: CGPoint = node.parent!.position
            
            self.zPosition = 10
            node.position = CGPoint(x: parent.x + location.x, y: parent.y + location.y)
            
         
        }
        
        
        
    }
    
}