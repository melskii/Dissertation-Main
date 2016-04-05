//
//  Levels.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 24/02/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import UIKit



/*
    This class will be contain a list of levels and depending on the level depends on what will be returned
*/



public class LevelData {
    
  
    let level: Int
    var instructions: [Block]
    var levelGrid: [[Object]]? //do 208 by 86
    //need to have one for output set up aswell but one step at time
    
    
    public init(level : Int){
        
        self.level = level
        instructions = [Block]()
        setInstructions(level)
        
    }
    
    
    
  
    public func getInstructions() -> [Block]{
       
        return instructions
    }

    private func setInstructions(level: Int) {
        
        if (level == 1) {
            
            instructions.append(Play())
            instructions.append(ObjectA())
            instructions.append(Up())
            instructions.append(Down())
            instructions.append(Right())
            instructions.append(Left())
    
        }
        
    
    }
    
    
}



