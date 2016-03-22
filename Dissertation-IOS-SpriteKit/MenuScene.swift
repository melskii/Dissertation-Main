//
//  MenuScene.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 18/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene, SKPhysicsContactDelegate {
    
    var _width, _height: CGFloat!
    var user: UserProfile!
    var menu: SKSpriteNode!
    var labelPosition: CGFloat!
   
    /*
        This function is called when the view appears
    */
    override func didMoveToView(view: SKView) {
        
        
        view.showsPhysics = true
        physicsWorld.contactDelegate = self
        
        //Setup your scene here
        self.backgroundColor = UIColor.whiteColor()
        
        _width = frame.size.width
        _height = frame.size.height
        
        let menuSprite = getMenuSprite()
        
        //set the height to the height - menu bar
        _height = _height - menuSprite.size.height
        
        addChild(menuSprite)
  
    }
  
    /*
        Get the menu SKSprite with it's children (logo, home and login/user buttons)
    */
    func getMenuSprite () -> SKSpriteNode {
        
        
        
        // Background for Menu
        menu = SKSpriteNode(imageNamed: "menuBackground.png")
        menu.size = CGSize(width: _width, height: 56)

        let x = (menu.size.width * 0.5)
        let y = _height - (menu.size.height * 0.5)
        menu.position = CGPoint(x: x, y: y)
        
        // Home Button
        let home = SKSpriteNode(imageNamed: "home.png")
        var aspect = home.size.width/home.size.height
        home.size = CGSize (width: 43 * aspect, height: 43)
        
        var pos = (-(menu.size.width/2)) + (home.size.width/2) + 5
        
        home.position = CGPoint(x: pos, y: 0)
        home.name = "home"
        
        // Tales Logo
        let logo = SKSpriteNode(imageNamed: "Grey Logo.png")
        aspect = logo.size.width/logo.size.height
        
        logo.alpha = 0.95 //change transparency
        logo.size = CGSize (width: 53 * aspect, height: 53)
        
        pos += ((logo.size.width/2)) + (home.size.width/2)  + 5 //menu 0,0 is the center, pos is logo center, plus padding
        
        logo.zPosition = 1
        logo.position = CGPoint (x: pos, y: 0)
        
        // Login & User Button
        let login = SKSpriteNode(imageNamed: "user.png")
        aspect = login.size.width/login.size.height
        login.size = CGSize (width: 43 * aspect, height: 43)
        
        pos = ((menu.size.width/2)) - (login.size.width/2) - 5
        labelPosition = pos - (login.size.width/2) - 10
        
        login.position = CGPoint (x: pos, y: 0)
        login.name = "login"
        
        // Add as children to menu
        menu.addChild(home)
        menu.addChild(logo)
        menu.addChild(login)

        return menu
        
    }
    
    /*
        Updates the user information and is stored in the menu for all templates to use.
    */
    func setParticipant(participant: UserProfile) {
        
        user = participant
        
        //return login button if getParticipantName returns nil
        if (user.getParticipantName() != nil)
        {
            let label = SKLabelNode(text: "Hello \(user.getParticipantName()!)!")
            
            label.fontColor = UIColor.blackColor()
            label.horizontalAlignmentMode = .Right
            label.verticalAlignmentMode = .Center
            
            let w = labelPosition //menu 0,0 is the center, pos is logo center, plus padding
            print ("Label \(labelPosition)")

            
            label.zPosition = 1
            label.position = CGPoint (x: w, y: 0)

            
            
            menu.addChild(label)
        }
        
    }
    
    /*
        Upates the screen when the buttons are pressed instead of touches began which is overridden when using other Scenes
    */
    func menuNodeForTouch(touchLocation: CGPoint, node: SKNode) {
        
        if node.name == "home" {
            
            if self.name != "HomeScene" {
                
                
                let transition = SKTransition.crossFadeWithDuration(0.5)
                let nextScene = HomeScene(size: scene!.size)
                nextScene.scaleMode = .AspectFill
                
                scene?.view?.presentScene(nextScene, transition: transition)
                nextScene.setParticipant(user)
                
                
            }
            
        }
        
        else if (node.name == "login") {
            
            var texture = [SKTexture]()
            
            texture.append(SKTexture(imageNamed: "user_pressed.png"))
            texture.append(SKTexture(imageNamed: "user.png"))
            
            let animation = SKAction.animateWithTextures(texture, timePerFrame: 0.2)
            node.runAction(animation)
            
            
        }
        
        
    }
    
    
    



}