//
//  GameScene.swift
//  SimpleGame2
//
//  Created by Kenny Batista on 1/20/16.
//  Copyright (c) 2016 Kenny Batista. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let player = SKSpriteNode(imageNamed: "marioFireBall.png")
    
    var background = SKSpriteNode(imageNamed: "background")
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
        background.position = CGPoint(x: frame.size.width / 1, y: frame.size.height / 1)
        
        addChild(background)
        
        player.position = CGPoint(x: size.width*0.2, y: size.height*0.5)
        player.xScale = 0.2
        player.yScale = 0.2
        self.addChild(player)
        
        runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.runBlock(addMonster),
            SKAction.waitForDuration(1.0)])))
        
        
        let backgroundMusic = SKAudioNode(fileNamed: "marioSong.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let ball = SKSpriteNode(imageNamed:"monster.png")
            
            ball.xScale = 0.1
            ball.yScale = 0.1
            ball.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            ball.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(ball)
        }
    }
    
    func addMonster() {
        let monster = SKSpriteNode(imageNamed: "monster.png")
        
        let actualY = random(monster.size.height/5, max:size.height-monster.size.height/5)
        monster.position = CGPoint(x:size.width+monster.size.width/5, y:actualY)
        
        monster.xScale = 0.1
        monster.yScale = 0.1
        
        
        addChild(monster)
        
        let actualDuration = random(CGFloat(2.0), max:CGFloat(4.0))
        
        let actionMove = SKAction.moveTo(CGPoint(x: -monster.size.width/2, y: actualY), duration:  NSTimeInterval(actualDuration))
        
        let actionMoveDone = SKAction.removeFromParent()
        
        let rotateAction = SKAction.rotateByAngle(CGFloat(M_PI), duration: 1)
            
        monster.runAction(SKAction.repeatActionForever(rotateAction))
        
        monster.runAction(SKAction.sequence([actionMove, actionMoveDone]))
        
        
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random())/0xFFFFFFFF)
    }
    
    func random(min:CGFloat, max:CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
