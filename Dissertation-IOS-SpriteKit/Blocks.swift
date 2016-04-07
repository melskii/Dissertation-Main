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






