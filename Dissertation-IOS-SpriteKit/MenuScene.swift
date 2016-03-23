//
//  MenuScene.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 18/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import SpriteKit

protocol GameSceneDelegate {
    
    
    func homeScene()
    
    func userScene()
    
    func setAudioFeedback (audio: Bool)
    
    func getAudioFeedback() -> Bool
    
    func getParticipantName () -> String?
    
}

class MenuScene: SKScene, SKPhysicsContactDelegate {
    
    var _width, _height: CGFloat!
    var menu: SKSpriteNode!
    var labelPosition: CGFloat!
    var audio: Bool = true
    
    var gameSceneDelegate: GameSceneDelegate?
   
  
    
    /*
        This function is called when the view appears
    */
    override func didMoveToView(view: SKView) {
        
     
        // get the Audio from GameViewController.
        let audio = gameSceneDelegate?.getAudioFeedback()
        
        if audio != nil {
            self.audio = audio!
        }
        
        view.showsPhysics = true
        physicsWorld.contactDelegate = self
        
        //Setup your scene here
        self.backgroundColor = UIColor.whiteColor()
        
        _width = frame.size.width
        _height = frame.size.height
        
        let menuSprite = getMenuSprite()
        
        //set the height to the height - menu bar
        _height = _height - menuSprite.size.height
        
//        setParticipant()
        
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
        
        
        
        // Tales Logo
        let logo = SKSpriteNode(imageNamed: "Grey Logo.png")
        var aspect = logo.size.width/logo.size.height
        
        logo.alpha = 0.95 //change transparency
        logo.size = CGSize (width: 53 * aspect, height: 53)
        
        var pos = (-(menu.size.width/2)) + (logo.size.width/2) + 5
        
        logo.zPosition = 1
        logo.position = CGPoint (x: pos, y: 0)
        
        // Audio Button
        var sound = SKSpriteNode(imageNamed: "audio.png")
        
        if audio == false {
            sound = SKSpriteNode(imageNamed: "mute.png")
        }
        
        aspect = sound.size.width/sound.size.height
        sound.size = CGSize (width: 33 * aspect, height: 33)
        
        pos += (logo.size.width/2) + (sound.size.width/2) + 10
        
        sound.position = CGPoint(x: pos, y:0)
        sound.name = "sound"
        
        
        // Home Button
        let home = setHomeButton()
        
        pos = ((menu.size.width/2)) - (home.size.width/2) - 5
        home.position = CGPoint(x: pos, y: 0)
        
        // Login & User Button
        let login = setLoginButton()
        pos -=  (login.size.width/2 + home.size.width/2) + 5
        labelPosition = pos - (login.size.width/2) - 10
        
        login.position = CGPoint (x: pos, y: 0)
        
        
        
        // Add as children to menu
        menu.addChild(logo)
        menu.addChild(home)
        menu.addChild(sound)
        menu.addChild(login)

        return menu
        
    }
    
    func setHomeButton () -> SKSpriteNode {
        
        let home = SKSpriteNode(imageNamed: "home.png")
        let aspect = home.size.width/home.size.height
        home.size = CGSize (width: 43 * aspect, height: 43)
    
        home.name = "home"
        
        return home
        
    }
    
    func setLoginButton () -> SKSpriteNode {
        
        let login = SKSpriteNode(imageNamed: "user.png")
        let aspect = login.size.width/login.size.height
        login.size = CGSize (width: 43 * aspect, height: 43)
        
        
        login.name = "login"
        
        return login
        
    }
    
    
    /*
        Updates the user information and is stored in the menu for all templates to use.
    */
    func setParticipant() {
        
        print (self.gameSceneDelegate)
        
       
        
        let user = self.gameSceneDelegate!.getParticipantName()
        
        //return login button if getParticipantName returns nil
        if (user != nil)
        {
            let label = SKLabelNode(text: "Hello \(user!)!")
            
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
        
        if (node.name == "home" && self.name != "UserScene") {
        
  
            
            var texture = [SKTexture]()
            
            texture.append(SKTexture(imageNamed: "home_pressed.png"))
            texture.append(SKTexture(imageNamed: "home.png"))
            
            let animation = SKAction.animateWithTextures(texture, timePerFrame: 0.2)
            node.runAction(animation)
            
            if self.name != "HomeScene" {
                
                print("home button")
         
                self.gameSceneDelegate?.homeScene()
                
            }
            
            
        }
        
        else if (node.name == "login" && self.name != "UserScene") {
            
            var texture = [SKTexture]()
            
            texture.append(SKTexture(imageNamed: "user_pressed.png"))
            texture.append(SKTexture(imageNamed: "user.png"))
            
            let animation = SKAction.animateWithTextures(texture, timePerFrame: 0.2)
            node.runAction(animation)
            
            print("login button")
            
            self.gameSceneDelegate?.userScene()
            
//            setNextScene(UserScene(size: scene!.size))
            
            
        }
        
        else if (node.name == "sound") {
            
            var texture = [SKTexture]()
            
            if audio == true {
                
                texture.append(SKTexture(imageNamed: "mute.png"))
                audio = false
                self.gameSceneDelegate?.setAudioFeedback(audio)
                
            }
            
            else {
                texture.append(SKTexture(imageNamed: "audio.png"))
                audio = true
                self.gameSceneDelegate?.setAudioFeedback(audio)
            }
            
            let animation = SKAction.animateWithTextures(texture, timePerFrame: 0.2)
            node.runAction(animation)
            
        }
        
        
    }
    
  

    
    deinit {
        
        print("deallocated")
        
    }

    
    
    



}