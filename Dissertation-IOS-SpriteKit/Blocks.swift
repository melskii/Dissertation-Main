//
//  Blocks.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 24/02/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import Foundation
import SpriteKit


//Unable to do Abstract Classes in Swift so this is the next best thing apparently
public class Block {
    
    var block: SKSpriteNode!
    var name, program: String!
    var highlight: [String]
    
    public init(){

        highlight = [String]()
    }
    
    private func setup(name: String) {
        
        self.name = name
        
        /*
            Could do this with SKTexture
            var shooterAnimation = SKTexture()
            let shooterAtlas = SKTextureAtlas(named: "shooter")
        */
    
        block = BlockSprite(imageNamed: "\(name)")
        block.name = "block_\(name)"
        block.setScale(0.6)
        
        highlight.append("\(name)_highlight")
        highlight.append(name)

        program = "program_\(name)"
      
    }
    
    /*
    public func press() -> [Any] {
    
        var press = [Any]()
        
        press.append(highlight)
        
        return press
    
    }*/
    
    public func press(scale: CGFloat, id: Int) -> Program {
        
        let p = Program(img: program, scale: scale, id: id)

        return p
        
    }
    
    public func pressAndHold() -> [Any] {
    
        return [Any]()
    
    }
    
   
    
    
  
}

class BlockSprite: SKSpriteNode {
    
}

/*
Split into subclasses for the parsing
*/


//Objects
class Object: Block {
    
    var type: OutputType!
    
    override init() {
        
        super.init()
        setup("objecta")
        
    }
    
    init(type: OutputType) {
        
        super.init()
        self.type = type
        
        var name = "object"
        
        switch (type) {
    
        case .B:
            name += "b"
        case .C:
            name += "c"
        default:
            name += "a"
        
        }
        
        setup(name)
        
    }
    
}

class Action: Block {
    
    internal func gridActionMove(cell: GameCell) -> (Int, Int) {
        
        return (cell.x, cell.y)
        
        
    }
    
    internal func animateAction(sprite: SKSpriteNode) {
        
        /*
        Code to make my Sprite Walk:
        let spriteAnimatedAtlas = SKTextureAtlas(named: sprite.name!)
        
        var walkFrames = [SKTexture]()
        
        let images = spriteAnimatedAtlas.textureNames.count
        
        for var i = 1; i <= images; i++ {
            let textureName = sprite.name! + String(i)
            walkFrames.append(spriteAnimatedAtlas.textureNamed(textureName))
        }
        
        let spriteWalkingFrames = walkFrames
        
        sprite.runAction(SKAction.repeatAction(
            SKAction.animateWithTextures(spriteWalkingFrames,
                timePerFrame: 0.1,
                resize: false,
                restore: true)
            
        , count: 5))
        */
        
        print(sprite)

        //let animateAction = SKAction.animateWithTextures(SOMETEXTURE, timePerFrame: 0.20)
        let moveAction = SKAction.moveBy(CGVector(dx: 100, dy: 0), duration: 0.5)
        let repeatAction = SKAction.repeatAction(moveAction, count: 2)
        sprite.runAction(repeatAction)
      
    }
    
    func spriteMoveEnded(sprite: SKSpriteNode) {
        sprite.removeAllActions()
    }
    
}

class Play: Block {
    
    override init() {
        
        super.init()
        setup("play")

    }
  
}

class Control: Block {
    
}



//Action
class Up: Action {
    
    override init() {
        
        super.init()
        setup("up")
        
    }
    
    override func gridActionMove(cell: GameCell) -> (Int, Int) {
        
        
        return (cell.x, cell.y + 1)
        
        
    }
    
    
    
    
}

class Down: Action {
    
    override init() {
        
        super.init()
        setup("down")
        
    }
    
    override func gridActionMove(cell: GameCell) -> (Int, Int) {
        
        
        return (cell.x, cell.y - 1)
        
        
    }
    
    
}

class Left: Action {
    
    override init() {
        
        super.init()
        setup("left")
        
    }
    
    override func gridActionMove(cell: GameCell) -> (Int, Int) {
        
        
        return (cell.x - 1, cell.y)
        
        
    }
    
    
}

class Right: Action {
    
    override init() {
        
        super.init()
        setup("right")
        
    }
    
    override func gridActionMove(cell: GameCell) -> (Int, Int) {
        
        
        return (cell.x + 1, cell.y)
        
        
    }
    
    
}

//Controls
class Repeat: Control {
    
    
    override init() {
        
        super.init()
        setup("repeat")
        
    }
    
    
}

class Wait: Control {
    
    override init() {
        
        super.init()
        setup("wait")
        
    }
    
    
}






