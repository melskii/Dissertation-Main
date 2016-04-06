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
    
  
    let level: Int
    var instructions: [Block]
    var levelGrid: [[GameCell]]! //do 10 by 5
    var x, y: Int!
    var backgroundImg: SKSpriteNode?
    //need to have one for output set up aswell but one step at time
    
    
    public init(level : Int){
        
        self.level = level
        
        //Set up the instruction Blocks
        instructions = [Block]()
        setInstructions()
        
        //Set up the Level Grid
        setOutputObjects()
        
    }
    
    private func initialOutputGrid(x: Int, y: Int) {
        
        self.x = x
        self.y = y
        
        for var i = 0; i < x; i++ {
            
            var sub = [GameCell]()
            
            for var j = 0; j < y; j++ {
                
                sub.append(GameCell(x: i, y: j))
                
            }
            
            levelGrid.append(sub)
        
        }
        
        print("level: \(levelGrid)")
        
    }
    
    
    
  
    func getInstructions() -> [Block]{
       
        return instructions
    }

    private func setInstructions() {
        
        if (self.level >= 1) {
            
            instructions.append(Play())
            instructions.append(Object(type: OutputType.A))
            instructions.append(Up())
            instructions.append(Down())
            instructions.append(Right())
            instructions.append(Left())
    
        }
        
        if (self.level >= 2) {
            
            instructions.append(Play())
            instructions.append(Object(type: OutputType.A))
            
        }
        
    
    }
    
    private func setOutputObjects() {
        
        levelGrid = [[GameCell]]()
        initialOutputGrid(10, y: 5)
        
        
        if (self.level == 1) {
            
            let objectA = OutputObject(imgName: "monkey", type: OutputType.A)
            let final = OutputObject(imgName: "house", type: OutputType.End)
            
            levelGrid[1][1].setOutputObject(objectA)
            levelGrid[7][3].setOutputObject(final)
            
        }
        
    }
    
    public func validProgram(prog: [Block]) -> Bool {
        
        setOutputObjects()
        
        var program = prog
        var objectCell: (type: OutputType, cell: GameCell)? = nil //The Cell of the Current Object
        var valid = false
        
        program.removeAtIndex(0) //Removes Play from Program - Has already been validated
        
        for b in program {
            
            valid = false
            
            print("program block: \(b)")
            
            if let object = b as? Object {
                
                
                guard let c = getCellWithType(object.type) else {
                    
                    break
                }
                
                
                print("object \(object.type)")
                objectCell = (object.type, c)
                
            }
            
            else if let action = b as? Action {
                
                print("object \(action.name)")
                
                if objectCell == nil {
                    
                    
                    break
                    
                }
                
                else {
                    
                
                
                    guard let pos: (x: Int, y: Int) = action.gridActionMove(objectCell!.cell) else {
                        
                        
                        break
                    }
                    
                    print("position \(pos) object: \(objectCell!.type)")
                    
                    //if the new pos are in bounds then continue and move the object
                    if (pos.x >= 0 && pos.x < x) && (pos.y >= 0 && pos.y < y)
                    {
                        
                        print("inside the bounds")
                        
                        let type = objectCell!.type
                        let currentCell = objectCell!.cell
                        let object = currentCell.getOutputObject(type)
                        
                        
                        
                        if object != nil {
                            
                            let newCell = levelGrid[pos.x][pos.y]

                            
                            print("object not null \(object)")
                            
                            
                            print("New Cell Before \(newCell.objects)")
                            print("Current Cell Before \(currentCell.objects)")
                        
                            //Remove from old Cell Location
                            currentCell.removeOutputObject(type)
                            
                            //Add to new Cell Location
                            newCell.setOutputObject(object!)
                            objectCell = (type, newCell)
                            
                            print("New Cell After \(newCell.objects)")
                            print("Current Cell After \(currentCell.objects)")
                            
                            
                            if (newCell.getOutputObject(OutputType.End) != nil) {
                                
                                valid = true
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                    }
                    
                    else {
                        
                        //animate off the screen but don't move in the grid
                        print ("out of bounds")
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

                if levelGrid[i][j].getOutputObject(type) != nil {

                    return levelGrid[i][j]

                }

            }
    
        }
        
        return nil
    }
    
    
}


public class GameCell {
    
    
    let x, y: Int
    var objects: [OutputType: OutputObject] = [:]
    
    
    init(x: Int, y: Int) {
        
        self.x = x
        self.y = y
        
        
        
    }
    
    func setOutputObject(object: OutputObject) {
        
        objects[object.type] = object
    }
    
    func removeOutputObject(type: OutputType) {
        
        objects.removeValueForKey(type)
        
    }
    
    func getOutputObject(type: OutputType) -> OutputObject? {
        
        return objects[type] != nil ? objects[type] : nil
        
    }
    
}



public class OutputObject {
    
    
    let sprite: SKSpriteNode!
    let name: String!
    let type: OutputType!
    var end: Bool = false
    
    
    init(imgName: String, type: OutputType) {
        
        self.sprite = SKSpriteNode(imageNamed: imgName)
        self.sprite.name = imgName
        
        self.name = imgName
        self.type = type
        
        switch (type) {
        case .End:
            self.end = true
        default:
            return
        }
        
    }
    
    
    
}



