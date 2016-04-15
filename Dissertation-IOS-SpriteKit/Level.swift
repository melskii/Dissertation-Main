//
//  Levels.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 24/02/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import UIKit
import SpriteKit


/*
    This class will be contain a list of levels and depending on the level depends on what will be returned
*/



public class Level {
    
    //updates depending on selected level (different to current Level)
    private let level: Int
    
    //Items that will be sent to GameScene
    private var _inst: [Block]
    private var _starting: [Block]
    var _lockedBlocks: Int = 0
    var _objects: [GameCell]! = [GameCell]() //this is for the animations in Game Scene.
    var _background: SKSpriteNode! = SKSpriteNode(imageNamed: "outBckground") //use outBckground as the default.
    var x, y: Int!
    var _description: Int = 0
    var _mainimg: UIImage?
    
    //The Level Game Grid!!!!
    private var _grid: [[GameCell]]! //do 10 by 5

    
    public init(level : Int){
        
        self.level = level
        
        //Set up the instruction Blocks
        _inst = [Block]()
        _starting = [Block]()
        
        setLevelInstructions()
        
        //Set up the Level Grid
        setLevelObjects()
        
    }
    
  
    func getInstructions() -> [Block]{
       
        return _inst
    }
    
    func startingBlocks() -> [Block] {
        
        return _starting
    }

    private func setLevelInstructions() {
        
        
        if (self.level >= 3){
            _inst.append(Play())
            
        }
        
        if (self.level >= 2) {
            
            
            _inst.append(Object(type: OutputType.A))
            
            
        }
        
        if self.level >= 4 {
            _inst.append(Object(type: OutputType.B))
            
        }
        
        if (self.level >= 1) {
            
            
            _inst.append(Up())
            _inst.append(Down())
            _inst.append(Right())
            _inst.append(Left())
            
            
    
        }
        
        if self.level == 1 {
            _starting.append(Play())
            _starting.append(Object(type: OutputType.A))
            _lockedBlocks = 2
        }
        else if self.level == 2 {
            _starting.append(Play())
            _lockedBlocks = 1
            
        }
    
    }
    
    private func setLevelObjects() {
        
        clearOutputGrid(10, y: 5) //loops 10 x 5
        
        
        if (self.level == 1) {
            
            if _objects.count == 0 {
           
                let End = GameCell (x: 4, y: 2)
                let A = GameCell(x: 1, y: 1)
                
                let house = TLSpriteNode(imageNamed: "house")
                house.name = "house"
                
                let objecta = TLSpriteNode(imageNamed: "giraffe")
                objecta.name = "giraffe"
                
                End.setOutputSprite(house, type: OutputType.End)
                A.setOutputSprite(objecta, type: OutputType.A)
    
                _objects.append(End)
                _objects.append(A)
                
                _background = SKSpriteNode(imageNamed: "level1background")
                
                _description = 6
                
                _mainimg = UIImage(named: "level1-4")
            }
            
            
            
            
        }
        
        if (self.level == 2) {
            
            if _objects.count == 0 {
                
                let End = GameCell (x: 7, y: 3)
                let A = GameCell(x: 1, y: 1)
                
                let door = TLSpriteNode(imageNamed: "Door")
                door.name = "door"
                
                let objecta = TLSpriteNode(imageNamed: "giraffe")
                objecta.name = "giraffe"
                
                End.setOutputSprite(door, type: OutputType.End)
                A.setOutputSprite(objecta, type: OutputType.A)
                
                _objects.append(End)
                _objects.append(A)
                
                _background = SKSpriteNode(imageNamed: "level2background")
                
                 _description = 4
                
                _mainimg = UIImage(named: "level2-3")!
            }
            
        }
    
        
        if (self.level == 3) {
            
            if _objects.count == 0 {
                
                let End = GameCell (x: 8, y: 3)
                let A = GameCell(x: 1, y: 1)
                
                let leaf = TLSpriteNode(imageNamed: "leaf")
                leaf.name = "leaf"
                
                let objecta = TLSpriteNode(imageNamed: "giraffe")
                objecta.name = "giraffe"
                
                End.setOutputSprite(leaf, type: OutputType.End)
                A.setOutputSprite(objecta, type: OutputType.A)
                
                _objects.append(End)
                _objects.append(A)
                
                _background = SKSpriteNode(imageNamed: "level3background")
                
                _description = 5
                
                _mainimg = UIImage(named: "level3-3")
            }
            
        }
        
        
        if (self.level == 4) {
            
            if _objects.count == 0 {
                
                let End = GameCell (x: 5, y: 3)
                let A = GameCell(x: 1, y: 1)
                let B = GameCell(x: 7, y: 1)
                
                let bowl = TLSpriteNode(imageNamed: "bowl")
                bowl.name = "bowl"
                
                let objecta = TLSpriteNode(imageNamed: "milk")
                objecta.name = "milk"
                
                let objectb = TLSpriteNode(imageNamed: "eggs")
                objectb.name = "eggs"
                
                End.setOutputSprite(bowl, type: OutputType.End)
                A.setOutputSprite(objecta, type: OutputType.A)
                B.setOutputSprite(objectb, type: OutputType.B)
                
                _objects.append(End)
                _objects.append(A)
                _objects.append(B)
                
                _background = SKSpriteNode(imageNamed: "levelBackground")
                
                 _description = 5
                _mainimg = UIImage(named: "level4-3")
            }
            
        }
        
        
        
        for cell in _objects {
         
            _grid[cell.x][cell.y].objects = cell.objects
    
        }
 
    }
    
    
    private func clearOutputGrid(x: Int, y: Int) {
        
        _grid = [[GameCell]]()
        
        self.x = x
        self.y = y
        
        for var i = 0; i < x; i++ {
            
            var sub = [GameCell]()
            
            for var j = 0; j < y; j++ {
                
                sub.append(GameCell(x: i, y: j))
                
            }
            
            _grid.append(sub)
            
        }
        
        
        
    }
    
    public func validProgram(prog: [Block]) -> Bool  {
        
        let compiled = compileProgram(prog)

        
        return compiled
        
    }
    
    

    public func runAnimation (compiled: Bool, completion: (animationComplete: Bool) -> Void) {
        
        var count = _objects.count-1
        
        for cell in _objects {
            
            for sprite in cell.objects {
                
                if sprite.0 != OutputType.End {
                    
                    sprite.1.animateWithActionSquence(!compiled) {
                        (status: Bool) in
                        
                        count--
                        
                        if count == 0 && status == true {
                            
                            completion(animationComplete: true)
                            
                        }
                        
                    }
                }
                
            }
            
        }
        
        
        if _objects.count == 0 {
            completion(animationComplete: true)
        }
        
        //Reset the animation if not true.
        if (!compiled) {
            setLevelObjects()
        }
        
        
    }
    
    public func stopAnimation() {
        
        for cell in _objects {
            
            for sprite in cell.objects {
                
                if sprite.0 != OutputType.End {
                    
                    sprite.1.resetAnimation()
                }
                
            }
            
        }

        
        
    }


    
    private func compileProgram (prog: [Block]) -> Bool {
      
        let program = prog
        var objectCell: (type: OutputType, cell: GameCell)? = nil //The Cell of the Current Object
        var valid = false
        var count = _objects.count-1
        
        for b in program {
            
            valid = false
            
           
            
            //Play is ignored!
            if let block = b as? Object {
                
                
                guard let c = getCellWithType(block.type) else {
                    
                    break
                }
                
                
                objectCell = (block.type, c)
                
            }
            
            else if let block = b as? Action {
                
                if objectCell == nil {
                    
                    
                    break
                    
                }
                
                else {
                    
                
                
                    guard let pos: (x: Int, y: Int) = block.gridActionMove(objectCell!.cell) else {
                        
                        
                        break
                    }
                    
                    let type = objectCell!.type
                    let currentCell = objectCell!.cell
                    let sprite = currentCell.getOutputSprite(type)
                    
                    
                    if sprite != nil {
                        
                        sprite?.appendActionSequence(block.spriteActionMove())


                        
                        //if the new pos are in bounds then continue and move the object
                        if (pos.x >= 0 && pos.x < x) && (pos.y >= 0 && pos.y < y)
                        {

                            //Animate and Move Sprite if it exists.
                            let newCell = _grid[pos.x][pos.y]

                            //Remove from old cell Location
                            currentCell.removeOutputSprite(type)
                            
                            //Add to new cell Location
                            newCell.setOutputSprite(sprite!, type: type)
                            objectCell = (type, newCell)
                       
                            
                            
                            if (newCell.getOutputSprite(OutputType.End) != nil) {
                                
                                count = count - 1
                                
                                if count == 0 {
                                    valid = true
                                }
                                
                                
                            }
                            
                        }
                        
                        else {
                            
                            //animate off the screen but don't move in the grid
                            //Debugging: print ("out of bounds")
                            break
                            
                        }
                    }
                    
                    
                    
                }
                
                
            }
            
        }
        
        
        
        return valid
        
    }
    
    
    private func getCellWithType(type: OutputType) -> GameCell? {
    

        for var i = 0; i < x; i++ {
            for var j = 0; j < y; j++ {

                if _grid[i][j].getOutputSprite(type) != nil {

                    return _grid[i][j]

                }

            }
    
        }
        
        return nil
    }
    
    
}


public class GameCell {
    
    
    var x, y: Int
    let original: (x: Int, y: Int)!
    var objects: [OutputType: TLSpriteNode] = [:]
    
    
    init(x: Int, y: Int) {
        
        self.x = x
        self.y = y
        
        self.original = (x, y)
        
        
        
    }
    
    func setOutputSprite(sprite: TLSpriteNode, type: OutputType) {
        
       
        objects[type] = sprite
    }
    
    func removeOutputSprite(type: OutputType) {
        
        objects.removeValueForKey(type)
        
    }
    
    func removeAllOutputSprites() {
        
        objects.removeAll()
    }
    
    func getOutputSprite(type: OutputType) -> TLSpriteNode? {
        
        return objects[type] != nil ? objects[type] : nil
        
    }
    
}
class TLSpriteNode: SKSpriteNode {
    
    private var start: CGPoint!
    private var actionSequence: [SKAction] = []
    

    
    func startPoint (start: CGPoint) {
        
        self.start = start
        
    }
    
    func appendActionSequence(location: CGPoint)  {
        
       
        //Code to make my Sprite Run:
        let spriteAnimatedAtlas = SKTextureAtlas(named: self.name!)
        
        var walkFrames = [SKTexture]()
        
        let images = spriteAnimatedAtlas.textureNames.count
        
        for var i = 1; i < images; i++ {
            let textureName = self.name! + String(i)
            walkFrames.append(spriteAnimatedAtlas.textureNamed(textureName))
        }
        
        let spriteWalkingFrames = walkFrames
        
        let runAction = SKAction.animateWithTextures(spriteWalkingFrames,
            timePerFrame: 0.1,
            resize: false,
            restore: true)
        
        //let animateAction = SKAction.animateWithTextures(SOMETEXTURE, timePerFrame: 0.20)
        
        
        let moveAction = SKAction.moveByX(location.x, y: location.y, duration: 0.5)
        
        let groupActions = SKAction.group([runAction, moveAction])

        actionSequence.append(groupActions)
        
    }
    
    func animateWithActionSquence (reset: Bool, completion: (status: Bool) -> Void) { //(location: CGVector) {
        
        
        
        if reset {
            
            actionSequence.append(SKAction.fadeOutWithDuration(0.3))
            actionSequence.append(SKAction.hide())
            actionSequence.append(SKAction.moveTo(start, duration: 0.3))
            actionSequence.append(SKAction.unhide())
            actionSequence.append(SKAction.fadeInWithDuration(0.3))
            
        }
        
        else
        {
            actionSequence.append(SKAction.fadeOutWithDuration(0.3))
        }
        
       
       let sequence = SKAction.sequence(actionSequence)
        
        self.runAction(sequence, completion: {
            
            self.actionSequence.removeAll()
            self.position = self.start
            completion(status: true)
            
            
            }
        )
       
    }
    
    func resetAnimation() {
        
        self.actionSequence.removeAll()
        
        self.removeAllActions()
               
        let sequence = SKAction.sequence(resetSequence())
        
               
        self.runAction(sequence, completion: {
            
            self.actionSequence.removeAll()
            self.position = self.start
            
            
            }
        )

        
        
    }
    
    private func resetSequence() -> [SKAction]{
        
        var a = [SKAction]()
        
        a.append(SKAction.fadeOutWithDuration(0.3))
        a.append(SKAction.hide())
        a.append(SKAction.moveTo(start, duration: 0.3))
        a.append(SKAction.unhide())
        a.append(SKAction.fadeInWithDuration(0.3))
        
        return a
    }

    
    
}





