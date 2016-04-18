//
//  File.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 30/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import Foundation
import UIKit

struct defaultKeys {
    
    static let User = "User"
}



//No class therefore globally accessable

let SHADOW_COLOUR: CGFloat = 157.0/255.00
let MENU_HEIGHT: CGFloat = 80


let defaults = NSUserDefaults.standardUserDefaults()
var USER: UserModel! = UserModel()
var _LEVEL = 1
let MAXLEVELS = 4
var LEVEL: Level!
var GAME_HEIGHT: CGFloat!
var USERDATA: NSUserData! = NSUserData()
var DEFAULTS: Bool = false

var OUTSQUARE: CGSize!


let URL = "http://users.sussex.ac.uk/~ms660/dissertation/"

public enum OutputType: String {
    case A = "ObjectA"
    case B = "ObjectB"
    case C = "ObjectC"
    case End = "End"
}

public enum UserStatus: String {
    case Disabled = "Disabled"
    case Active = "Active"
    case NoUser = "No User Available for that number"
    case BadConn = "Unable to Connect"
    case BadJSON = "Unable to Parse JSON"
    case Invalid = "Invalid text entered into the box"
}

public enum AnimationStatus {
    case Start 
    case Stop

}


public enum FeedbackType: String {
    
    case InvalidSyntax = "Parse"
    case InvalidProgram = "Code"
    case LevelComplete = "Level Complete"
    case LevelHelp = "Level Help"
    
}

let CodeFeedbackString : [(feedback: String, name: Bool)] = [
        ("Nice Try", true),
        ("Whoops", false),
        ("Nearly There!", false),
        ("Oops", false)
    ]

let SyntaxFeedbackString : [(feedback: String, name: Bool)] = [
    ("Nice Try", true),
    ("Whoops", false),
    ("Try Again", false),
    ("Oops", false)
]



