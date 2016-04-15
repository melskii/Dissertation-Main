//
//  GameScene.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 26/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//



import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate, UIGestureRecognizerDelegate {
    
    var blocks : [String: Block] = [:]
    
    var inst, prog, out : SKSpriteNode!
    var _outSquare: CGSize!
    
    //All about the program
    var pointer: CGPoint! //Program co-ordinates pointer
    
    var width, height: CGFloat!
    
    var bounds: CGFloat = 200 //Out of bounds counter NEED TO INCLUDE HEIGHT AND WIDTH BOUNDS. TRANSFORM THE BLOCKS TO HALF SIZE
    var boundsy: CGFloat = 100
    var progscale: CGFloat = 0.6

    
    var gameSceneDelegate: GameDelegate? //Delegate is in GameViewController
    
    var binSprite: SKSpriteNode!
    
    
    override func didMoveToView(view: SKView) {
        
        super.didMoveToView(view)
        
        self.name = "GameScene"
        
        view.showsPhysics = true
        physicsWorld.contactDelegate = self
        
        
        self.backgroundColor = UIColor.whiteColor()
        self.width = frame.size.width
        self.height = frame.size.height - 80
        
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
        
        
        //default anchor point is in Spritekit is (0.5, 0.5) which is center of the node/sprite (0,0)
        //set the new co-ordinates to work from.
        //work out the initial values for everything.
        var pos = CGPointMake(-(body.size.width/2), body.size.height/2)
        var i = 0
        let inst = LEVEL.getInstructions()
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
            b.block.zPosition = 3
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
        
        
        //set up starting blocks
        let startingProgram = LEVEL.getFixedBlocks()
        
        for block in startingProgram {
            self.gameSceneDelegate?.appendProgramFlowBlock(block)
        }
        
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
        
        body.zPosition = -1
        
        
        let background = LEVEL._background
        background.aspectFillToSize(body.size)
        background.zPosition = -2
   
        let _width = body.size.width/10
        let _height = body.size.height/5
        
        _outSquare = CGSize(width: _width , height: _height)
        OUTSQUARE = _outSquare
    
        let start = CGPoint(x: -(body.size.width * 0.5) + (_outSquare.width * 0.5), y: -(body.size.height * 0.5) + (_outSquare.height * 0.5))
        
        for cell in LEVEL._objects {
            
            for object in cell.objects {
                
                let sprite = object.1
                let type = object.0
                
                sprite.aspectFillToSize(_outSquare, type: type)
                let point: CGPoint = CGPoint(x: start.x + (_outSquare.width * CGFloat(cell.x)), y: start.y + (_outSquare.height * CGFloat(cell.y)))
                sprite.position = point
                
                sprite.startPoint(point)
                body.addChild(sprite)
                
            }
            
        }
        
        body.addChild(background)
        
        
        
        
        
        
        
        
        return body
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if !(self.paused) {
            
            /* Called when a touch begins */
            let touch = touches
            let location = touch.first!.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            selectNodeForTouch(location, node: node, touch: nil)
            
        }
        
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
        
        for (var i = images; i >= 1; i -= 1) {
            
            let texture = binAnimateAtlas.textureNamed(String(format:"bin%d", i))
            
            textures.append(texture)
            
        }
        
        let animateAction = SKAction.animateWithTextures(textures, timePerFrame: 0.12);
        
        
        binSprite.runAction(animateAction)

        
    }
    
   

    
}

extension SKSpriteNode {
    
    
    
    func aspectFillToSize(fillSize: CGSize, type: OutputType = OutputType.End) {
        
        if texture != nil {
            self.size = texture!.size()
            
            let verticalRatio = fillSize.height / self.texture!.size().height
            let horizontalRatio = fillSize.width /  self.texture!.size().width
            
            let scaleRatio = horizontalRatio > verticalRatio ? horizontalRatio : verticalRatio
            
            
            
            var scale = scaleRatio * (type != OutputType.End ? 0.5 : 1)
            
            if _LEVEL == 4 {
                scale = scaleRatio
            }
            
            self.setScale(scale)
            
        }
    }
    
   
    
}

//class TalesSpriteNode: SKSpriteNode {
//    
//    var outputPoint: CGPoint?
//    
//    func positionInOutput(position: CGPoint) {
//        
//        self.outputPoint = position
//    }
//    
//}

