//
//  GameScene.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 26/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//



import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate, UIGestureRecognizerDelegate {
    
    
    var level: Int = 1
    
    var blocks : [String: Block] = [:]
    var programs :[Program] = []
    
    var inst, prog, out : SKSpriteNode!
    
    //All about the program
    var pointer: CGPoint! //Program co-ordinates pointer
    var bounds: CGFloat = 200 //Out of bounds counter NEED TO INCLUDE HEIGHT AND WIDTH BOUNDS. TRANSFORM THE BLOCKS TO HALF SIZE
    var boundsy: CGFloat = 100
    var progscale: CGFloat = 0.6
    
    var width, height: CGFloat!
    
    var gameSceneDelegate: GameDelegate? //Delegate is in GameViewController
    
    var binSprite: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        
        super.didMoveToView(view)
        
        self.name = "GameScene"
        
        view.showsPhysics = true
        physicsWorld.contactDelegate = self
        
        
        self.backgroundColor = UIColor.whiteColor()
        self.width = frame.size.width
        self.height = frame.size.height - 54
        
        //Set up Instruction Blocks
        inst = setupInstructionBlocks()
        addChild(inst)
        
        //Set up Program
        prog = setupProgram()
        addChild(prog)
        
        
        //Set up Output
        out = setupOutput()
        addChild(out)
        
    }
    
    /*
    (0, 0) width = _width * (1/3) | height = _height * 0.5
    */
    func setupInstructionBlocks() -> SKSpriteNode {
        
        //set the size of the section
        let height = self.height * 0.5
        let width = (self.width * (1/3.5)) + 4
        
        let body = SKSpriteNode(imageNamed: "instBackground")
        body.size = CGSize(width: width, height: height)
        
        
        //set the position of the section
        let x = (body.size.width * 0.5)
        let y = self.height - (body.size.height * 0.5)
        body.position = CGPoint(x: x, y: y)
        
        
        
        body.name = "instructionBackground"
        
        
        //set up the level
        let levelData = LevelData(level: level)
        
        
        //default anchor point is in Spritekit is (0.5, 0.5) which is center of the node/sprite (0,0)
        //set the new co-ordinates to work from.
        //work out the initial values for everything.
        var pos = CGPointMake(-(body.size.width/2), body.size.height/2)
        var i = 0
        let inst = levelData.getInstructions()
        let blocksize = inst.first?.block.size
        
        
       
        var comp:Int = 0
        
        if blocksize != nil {
            comp = Int(height/(blocksize!.height + 10))
        }
        
        
        for b in inst {
            
            
            blocks[b.block.name!] = b
            
            //set the initial position.
            if i == 0 {
                
                pos.x += (blocksize!.width * 0.7)
                pos.y -= (blocksize!.height * 0.7)
                
                
            }
                
            else if (i % comp == 0) {
                
                pos.x += blocksize!.width + 10 //move x along and leave padding
                pos.y = (body.size.height/2) - (blocksize!.height * 0.7)  //reset y to the top
                
                
            }
                
            else {
                
                pos.y -= blocksize!.height + 10  //move y down and leave padding
                
                
            }
            
            i = i + 1
            
            b.block.position = pos
            body.addChild(b.block)
            
        }
        
        return body
        
    }
    
    
    /*
    *  (_width * (1/3), 0) width = _width * (2/3) | height = _height * 0.5
    */
    func setupProgram() -> SKSpriteNode {
        
        let body = SKSpriteNode(imageNamed: "prgBckground")
        body.size = CGSize(width: self.width * (1 - 1/3.5), height: self.height * 0.5)
        body.position = CGPoint(x: (self.width * (1/3.5)) + (body.size.width * 0.5), y: self.height - (body.size.height * 0.5))
        body.zPosition = -1
        body.name = "programBackground"
        
        
        //Program Pointer
        pointer = CGPointMake(-(body.size.width/2), body.size.height/2)
        
        
        binSprite = SKSpriteNode(imageNamed: "bin1")
        binSprite.name = "bin"
        
        binSprite.xScale = 0.15
        binSprite.yScale = 0.15
        
        //opposite corner of the initial block
        binSprite.position = CGPointMake((body.size.width/2), -(body.size.height/2))
        binSprite.position.x -= (binSprite.size.width * 0.7)
        binSprite.position.y += (binSprite.size.height * 0.7)
        
        
        body.addChild(binSprite)
        
        
        return body
        
    }
    
    /*
    (0, height * 0.5) width = _width | height = _height * 0.5
    */
    func setupOutput() -> SKSpriteNode {
        
        let body = SKSpriteNode(imageNamed: "outBckground")
        body.size = CGSize(width: self.width, height: self.height * 0.5)
        body.position = CGPoint(x: (body.size.width * 0.5), y: (body.size.height * 0.5))
        body.name = "outputBackground"
        
        print(body)
        
        return body
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        /* Called when a touch begins */
        let touch = touches
        let location = touch.first!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        
        selectNodeForTouch(location, node: node, touch: nil)
        
    }
    
    
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            selectNodeForTouch(location, node: node, touch: touch)
            
            
        }
        
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            touchedNode.zPosition = 0
        }
        
    }
 
    
    func selectNodeForTouch(let touchLocation: CGPoint, node: SKNode, touch: UITouch?) {
        
        
        let touchedNode = node
        
        if (touchedNode is BlockSprite && touch == nil) {
            
            let block:Block? = blocks[node.name!]
            
            var texture = [SKTexture]()
            
            if (block?.highlight.count > 0) {
                
                for t in (block?.highlight)! {
                    texture.append(SKTexture(imageNamed: (t)))
                }
                
                if (block != nil) {
                    
                    let animation = SKAction.animateWithTextures(texture, timePerFrame: 0.2)
                    node.runAction(animation)
                    
                    self.gameSceneDelegate?.appendProgramFlowBlock(block!)
                    
                    
                    
                }
                
            }
            
        }

        else if touchedNode.name == "bin" {
            
            animateBin()
            
        }
        
    }
    
    func animateBin () {
        
        let binAnimateAtlas: SKTextureAtlas = SKTextureAtlas(named: "bin")
        
        let images = binAnimateAtlas.textureNames.count;
        
        var textures: [SKTexture] = []
        
        for (var i = images; i >= 1; i--) {
            
            let texture = binAnimateAtlas.textureNamed(String(format:"bin%d", i))
            
            textures.append(texture)
            
        }
        
        let animateAction = SKAction.animateWithTextures(textures, timePerFrame: 0.12);
        
        
        binSprite.runAction(animateAction)

        
    }
    
   

    
}

