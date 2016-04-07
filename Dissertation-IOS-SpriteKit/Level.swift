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
        setLevelObjects()
        
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
    
    private func setLevelObjects() {
        
        clearOutputGrid(10, y: 5) //loops 10 x 5
        
        
        if (self.level == 1) {
            
            if _objects.count == 0 {
            
                let A = GameCell(x: 1, y: 1)
                let B = GameCell(x: 1, y: 2)
                let End = GameCell (x: 7, y: 3)
                
                
                A.setOutputObject(SKSpriteNode(imageNamed: "monkey"), type: OutputType.A)
                B.setOutputObject(SKSpriteNode(imageNamed: "monkey"), type: OutputType.B)
                End.setOutputObject(SKSpriteNode(imageNamed: "house"), type: OutputType.End)
                
                _objects.append(A)
                _objects.append(B)
                _objects.append(End)
                
                _background = SKSpriteNode(imageNamed: "homebackground")
            }
       
            for cell in _objects {
                
                _grid[cell.x][cell.y].objects = cell.objects
                
            }
            
          
                
            
            
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
    


    
    public func validProgram(prog: [Block]) -> Bool {
        
        setLevelObjects()
        
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
                        let object = currentCell.getOutputObject(type)
                        
                        print("hello")
                        
                        
                        print("preanimate: \(object))")
                    
                        print(_objects[0].objects[OutputType.A])
                        
                        
                        
                        if object != nil {
                            
                            action.animateAction(object!)
                            
                            let newCell = _grid[pos.x][pos.y]

                            
                            //Debugging: print("object not null \(object)")
                            
                            
                            //Debugging: print("New Cell Before \(newCell.objects)")
                            //Debugging: print("Current Cell Before \(currentCell.objects)")
                        
                            //Remove from old cell Location
                            currentCell.removeOutputObject(type)
                            
                            //Add to new cell Location
                            newCell.setOutputObject(object!, type: type)
                            objectCell = (type, newCell)
                            
                            //Debugging: print("New Cell After \(newCell.objects)")
                            //Debugging: print("Current Cell After \(currentCell.objects)")
                            
                            
                            if (newCell.getOutputObject(OutputType.End) != nil) {
                                
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

                if _grid[i][j].getOutputObject(type) != nil {

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
    var objects: [OutputType: SKSpriteNode] = [:]
    
    
    init(x: Int, y: Int) {
        
        self.x = x
        self.y = y
        
        self.original = (x, y)
        
        
        
    }
    
    func setOutputObject(sprite: SKSpriteNode, type: OutputType) {
        
        sprite.name = type.rawValue
        objects[type] = sprite
    }
    
    func removeOutputObject(type: OutputType) {
        
        objects.removeValueForKey(type)
        
    }
    
    func removeAllOutputObjects() {
        
        objects.removeAll()
    }
    
    func getOutputObject(type: OutputType) -> SKSpriteNode? {
        
        return objects[type] != nil ? objects[type] : nil
        
    }
    
}





