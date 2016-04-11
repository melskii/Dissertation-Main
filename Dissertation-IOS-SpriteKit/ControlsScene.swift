//
//  ControlsScene.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 26/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import SpriteKit


protocol ControlsSceneDelegate {
    
    
    func homeScene()
    
    func userScene()
    
    func setAudioFeedback (audio: Bool)
    
    func getAudioFeedback() -> Bool
    
    func getParticipantName () -> String?
    
}


class ControlsScene: SKScene {
    
    var controlsSceneDelegate: ControlsSceneDelegate?
    var audio: Bool = true
    var width: CGFloat?
    let height: CGFloat = 56
    
    override func didMoveToView(view: SKView) {
        
        super.didMoveToView(view)
        
        self.width = frame.size.width
    
        
        view.showsPhysics = true
        
        self.backgroundColor = UIColor.whiteColor()

        
        let menu = menuSprite()
       
        
        self.addChild(menu)
        
        
        
        let audio = controlsSceneDelegate?.getAudioFeedback()
        
        if audio != nil {
            self.audio = audio!
        }
        
        /*
            setParticipant()
        */

        
        
    }
    
    /*
        Get the menu SKSprite with it's children (logo, home and login/user buttons)
    */
    func menuSprite () -> SKSpriteNode {
        
        //Mute String
        let audioImg: String = (audio ? "audio.png" : "mute.png")
    
        //SKSpriteNodes
        let menu = SKSpriteNode(imageNamed: "menuBackground.png")
        let lblLogo = SKSpriteNode(imageNamed: "Grey Logo.png")
        let btnAudio = SKSpriteNode(imageNamed: audioImg)
        let btnHome = SKSpriteNode(imageNamed: "home.png")
        let btnLogin = SKSpriteNode(imageNamed: "user.png")
        
        //Set Variables to use throughout.
        var aspect: CGFloat!
        var x: CGFloat
        let h = height - 5
        
        //Menu Background
        menu.size = CGSize(width: width!, height: height)
        menu.position = CGPoint(x: (width! * 0.5), y: (frame.height * 0.5))
        
        //Logo Label
        aspect = lblLogo.size.width/lblLogo.size.height
        lblLogo.alpha = 0.95 //change transparency
        lblLogo.size = CGSize (width: h * aspect, height: h)
        lblLogo.zPosition = 1
        
                
        x = (-(menu.size.width/2)) + (lblLogo.size.width/2) + 5
        lblLogo.position = CGPoint (x: x, y: 0)
        
      

     
        //Audio Button
        aspect = btnAudio.size.width/btnAudio.size.height
        btnAudio.size = CGSize (width: (h - 5) * aspect, height: h - 5)
        btnAudio.zPosition = 1
        
        x += (lblLogo.size.width/2) + (btnAudio.size.width/2) + 10
        btnAudio.position = CGPoint(x: x, y:0)
        btnAudio.name = "btnAudio"
        
        
        // Home Button
        aspect = btnHome.size.width/btnHome.size.height
        btnHome.size = CGSize (width: h * aspect, height: h)
        btnHome.zPosition = 1
        
        x = ((menu.size.width/2)) - (btnHome.size.width/2) - 5
        btnHome.position = CGPoint(x: x, y: 0)
        btnHome.name = "btnHome"
        
        // Login & User Button
        aspect = btnLogin.size.width/btnLogin.size.height
        btnLogin.size = CGSize (width: h * aspect, height: h)
        btnLogin.zPosition = 1

        x -=  (btnLogin.size.width/2 + btnHome.size.width/2) + 5
        btnLogin.position = CGPoint (x: x, y: 0)
        btnLogin.name = "btnLogin"
        
        let labelPosition = x - (btnLogin.size.width/2) - 10
        
        
        
        // Add as children to menu
        menu.addChild(lblLogo)
        menu.addChild(btnHome)
        menu.addChild(btnAudio)
        menu.addChild(btnLogin)
        
        return menu
        
    }
    

    
    /*
    Upates the screen when the buttons are pressed instead of touches began which is overridden when using other Scenes
    */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        /* Called when a touch begins */
        let touch = touches
        let location = touch.first!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        
        if (node.name == "btnHome") {
            
            
            
            var texture = [SKTexture]()
            
            texture.append(SKTexture(imageNamed: "home_pressed.png"))
            texture.append(SKTexture(imageNamed: "home.png"))
            
            let animation = SKAction.animateWithTextures(texture, timePerFrame: 0.2)
            node.runAction(animation)
            
            if self.name != "HomeScene" {
                
                self.controlsSceneDelegate?.homeScene()
            
            }
            
            
        }
            
        else if (node.name == "btnLogin") {
            
            var texture = [SKTexture]()
            
            texture.append(SKTexture(imageNamed: "user_pressed.png"))
            texture.append(SKTexture(imageNamed: "user.png"))
            
            let animation = SKAction.animateWithTextures(texture, timePerFrame: 0.2)
            node.runAction(animation)
            
           
            
            self.controlsSceneDelegate?.userScene()
            
        
            
            
        }
            
        else if (node.name == "btnAudio") {
            
            
            var texture = [SKTexture]()
            
            texture.append(SKTexture(imageNamed: audio ? "mute.png" : "audio.png"))
            audio = audio ? false : true
            self.controlsSceneDelegate?.setAudioFeedback(audio)
            
            let animation = SKAction.animateWithTextures(texture, timePerFrame: 0.2)
            node.runAction(animation)
            
            /*
            if audio == true {
                
                texture.append(SKTexture(imageNamed: "mute.png"))
                audio = false
                self.controlsSceneDelegate?.setAudioFeedback(audio)
                
            }
                
            else {
                texture.append(SKTexture(imageNamed: "audio.png"))
                audio = true
                self.controlsSceneDelegate?.setAudioFeedback(audio)
            }
            */
            
            
            
        }
        
        
    }
    
    
    
    
    deinit {
        
        print("deallocated")
        
    }
    
 
    

}