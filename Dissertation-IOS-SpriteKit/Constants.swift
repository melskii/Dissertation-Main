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
var LEVEL: Level = Level(level: _LEVEL)
var GAME_HEIGHT: CGFloat!

var OUTSQUARE: CGSize!



let URL = "http://melbook.local/website/ipad/"

public enum OutputType: String {
    case A = "ObjectA"
    case B = "ObjectB"
    case C = "ObjectC"
    case End = "End"
}