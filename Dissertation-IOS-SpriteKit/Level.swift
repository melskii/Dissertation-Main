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
    var _objects: [GameCell]! = [GameCell]() //this is for the animations in Game Scene.
    var _background: SKSpriteNode! = SKSpriteNode(imageNamed: "outBckground") //use outBckground as the default.
    var x, y: Int!
    
    //The Level Game Grid!!!!
    private var _grid: [[GameCell]]! //do 10 by 5

    
    public init(level : Int){
        
        self.level = level
        
        //Set up the instruction Blocks
        _inst = [Block]()
        setLevelInstructions()
        
        //Set up the Level Grid
        setLevelObjects(false)
        
    }
    
  
    func getInstructions() -> [Block]{
       
        return _inst
    }

    private func setLevelInstructions() {
        
        if (self.level >= 1) {
            
            _inst.append(Play())
            _inst.append(Object(type: OutputType.A))
            _inst.append(Up())
            _inst.append(Down())
            _inst.append(Right())
            _inst.append(Left())
    
        }
        
        if (self.level >= 2) {
            
            _inst.append(Play())
            _inst.append(Object(type: OutputType.A))
            
        }
        
    
    }
    
    private func setLevelObjects(reset: Bool) {
        
        clearOutputGrid(10, y: 5) //loops 10 x 5
        
        
        if (self.level == 1) {
            
            if _objects.count == 0 {
            
                let A = GameCell(x: 1, y: 1)
           
                let End = GameCell (x: 7, y: 3)
                
                
                A.setOutputSprite(TLSpriteNode(imageNamed: "monkey"), type: OutputType.A)
             
                End.setOutputSprite(TLSpriteNode(imageNamed: "house"), type: OutputType.End)
                
                _objects.append(A)
                
                _objects.append(End)
                
                _background = SKSpriteNode(imageNamed: "homebackground")
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
        
        for cell in _objects {
            
            for sprite in cell.objects {
                
                sprite.1.animateWithActionSquence(!compiled)
                
            }
            
        }
        
        return compiled
        
    }


    
    private func compileProgram (prog: [Block]) -> Bool {
        
        
        
        var program = prog
        var objectCell: (type: OutputType, cell: GameCell)? = nil //The Cell of the Current Object
        var valid = false
        
        program.removeAtIndex(0) //Removes Play from Program - Has already been validated
        
        for b in program {
            
            valid = false
            
            //Debugging: print("program block: \(b)")
            
            if let object = b as? Object {
                
                
                guard let c = getCellWithType(object.type) else {
                    
                    break
                }
                
                
                //Debugging: print("object \(object.type)")
                objectCell = (object.type, c)
                
            }
            
            else if let action = b as? Action {
                
                //Debugging: print("object \(action.name)")
                
                if objectCell == nil {
                    
                    
                    break
                    
                }
                
                else {
                    
                
                
                    guard let pos: (x: Int, y: Int) = action.gridActionMove(objectCell!.cell) else {
                        
                        
                        break
                    }
                    
                    
                    //Debugging: print("position \(pos) object: \(objectCell!.type)")
                    
                    //if the new pos are in bounds then continue and move the object
                    if (pos.x >= 0 && pos.x < x) && (pos.y >= 0 && pos.y < y)
                    {
                        
                        //Debugging: print("inside the bounds")
                        
                        let type = objectCell!.type
                        let currentCell = objectCell!.cell
                        let sprite = currentCell.getOutputSprite(type)
                        
                        print("hello")
                        
                        
                        print("preanimate: \(sprite))")
                    
                        print(_objects[0].objects[OutputType.A])
                        
                        
                        //Animate and Move Sprite if it exists.
                        if sprite != nil {
                            
                            sprite?.appendActionSequence()
                            
                            let newCell = _grid[pos.x][pos.y]

                            
                            //Debugging: print("object not null \(object)")
                            
                            
                            //Debugging: print("New Cell Before \(newCell.objects)")
                            //Debugging: print("Current Cell Before \(currentCell.objects)")
                        
                            //Remove from old cell Location
                            currentCell.removeOutputSprite(type)
                            
                            //Add to new cell Location
                            newCell.setOutputSprite(sprite!, type: type)
                            objectCell = (type, newCell)
                            
                            //Debugging: print("New Cell After \(newCell.objects)")
                            //Debugging: print("Current Cell After \(currentCell.objects)")
                            
                            
                            if (newCell.getOutputSprite(OutputType.End) != nil) {
                                
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
        
        sprite.name = type.rawValue
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
    
    func appendActionSequence()  {
        
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

        
        //let animateAction = SKAction.animateWithTextures(SOMETEXTURE, timePerFrame: 0.20)
        let location = CGVector(dx: 100, dy: 0)
        let moveAction = SKAction.moveBy(location, duration: 0.5)
        actionSequence.append(moveAction)
        
    }
    
    func animateWithActionSquence (reset: Bool) { //(location: CGVector) {
        
        
        
        
        if reset {
            
            actionSequence.append(SKAction.moveTo(start, duration: 0.3))
            
        }
       
       let sequence = SKAction.sequence(actionSequence)
        
        self.runAction(sequence, completion: {
            
            self.actionSequence.removeAll()
            
            
            }
        )
    }
    
    
}





