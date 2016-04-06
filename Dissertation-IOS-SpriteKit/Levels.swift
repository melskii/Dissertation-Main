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



public class LevelData {
    
  
    let level: Int
    var instructions: [Block]
    var levelGrid: [[GameCell]] = [[GameCell]]() //do 10 by 5 
    var x, y: Int!
    var backgroundImg: SKSpriteNode?
    //need to have one for output set up aswell but one step at time
    
    
    public init(level : Int){
        
        self.level = level
        instructions = [Block]()
        setInstructions()
        initialOutputGrid(10, y: 5)
        
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
        
        if (self.level == 1) {
            
            let objectA = OutputObject(imgName: "monkey", type: OutputType.A)
            let final = OutputObject(imgName: "house", type: OutputType.End)
            
            levelGrid[1][1].setOutputObject(objectA)
            levelGrid[8][3].setOutputObject(final)
            
        }
        
    }
    
    public func validProgram(prog: [Block]) -> Bool {
        
        var program = prog
        var cell: GameCell? = nil //The Cell of the Current Object
        var valid = false
        
        program.removeAtIndex(0) //Removes Play from Program - Has already been validated
        
        for b in program {
            
            if let block = b as? Object {
                
                cell = getCellWithType(block.type)
                
            }
            
            else if let block = b as? Action {
                
                if cell == nil {
                    
                    
                    break
                    
                }
                
                guard let pos: (x: Int, y: Int) = block.gridAction(cell!) else {
                    
                    
                    break
                }
                
                //if the new pos are in bounds then continue and move the object
                if (pos.x >= 0 && pos.x < x) && (pos.y >= 0 && pos.y < y)
                {
                    
                    let object = cell!.object
                    
                    cell!.resetOutputObject()
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
                else {
                    
                    //animate off the screen but don't move in the grid
                    
                    break
                    
                }
                
                
            }
            
        }
        
        
        return valid
        
    }
    
    
    private func getCellWithType(type: OutputType) -> GameCell? {
    

        for var i = 0; i < x; i++ {
            for var j = 0; j < y; j++ {

                let obj = levelGrid[i][j].object

                if obj?[type] != nil {

                    return levelGrid[i][j]

                }

            }
    
        }
        
        return nil
    }
    
    
}


public class GameCell {
    
    
    let x, y: Int
    var object: [OutputType: OutputObject]?
    
    
    init(x: Int, y: Int) {
        
        self.x = x
        self.y = y
        
    }
    
    func setOutputObject(object: OutputObject) {
        
        self.object = [object.type :object]
    }
    
    func resetOutputObject() {
        self.object = nil
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



