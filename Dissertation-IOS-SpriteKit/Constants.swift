//
//  File.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 30/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import Foundation
import UIKit

//No class therefore globally accessable

let SHADOW_COLOUR: CGFloat = 157.0/255.00
let MENU_HEIGHT: CGFloat = 56


let USER: UserModel = UserModel()
var _LEVEL = 1
let MAXLEVELS = 5
var LEVEL: Level!
var GAME_HEIGHT: CGFloat!


var OUTSQUARE: CGSize!


let URL = "http://melbook.local/website/ipad/"

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