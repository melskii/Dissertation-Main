//
//  UserProfile.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 20/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import Foundation


public class UserProfile {

    
    var participant: Int!
    var name: String

    public init(participant: Int) {
        
        self.participant = participant
        
        self.name = "Mel"
        
        
    }
    
    func getParticipantName() -> String?{
        
        
        return name
    }
    


}