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

class Object: Block {
    
}

class Action: Block {
    
}

class Play: Block {
    
    override init() {
        
        super.init()
        setup("play")

    }
  
}

class Control: Block {
    
}


//Objects
class ObjectA: Object {
    
    override init() {
        
        super.init()
        setup("objecta")
        
    }
    
    
}

class ObjectB: Object {
    
    override init() {
        
        super.init()
        setup("objectb")
        
    }
    
    
}

class ObjectC: Object {
    
    override init() {
        
        super.init()
        setup("objectc")
        
    }
    
    
}


//Action
class Up: Action {
    
    override init() {
        
        super.init()
        setup("up")
        
    }
    
    
}

class Down: Action {
    
    override init() {
        
        super.init()
        setup("down")
        
    }
    
    
}

class Left: Action {
    
    override init() {
        
        super.init()
        setup("left")
        
    }
    
    
}

class Right: Action {
    
    override init() {
        
        super.init()
        setup("right")
        
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






