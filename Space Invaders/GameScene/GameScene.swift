//
//  GameScene.swift
//  Space Invaders
//
//  Created by Fatih inan on 2/17/18.
//  Copyright © 2018 Fatih inan. All rights reserved.
//

import SpriteKit
import GameplayKit

let screenSize = UIScreen.main.bounds
var screenWidth: CGFloat?

var screenHeight: CGFloat?

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    var boss: SKSpriteNode?
    var weapon: SKSpriteNode?
    var greenBug: SKSpriteNode?
    var redBug: SKSpriteNode?
    var blueBug: SKSpriteNode?
    var bullet: SKSpriteNode?
    
    var fireRate:TimeInterval = 0.5
    var timeSinceFire:TimeInterval = 0
    var lastTime:TimeInterval = 0
    
    let noCategory:UInt32 = 0
    let bulletCategory:UInt32 = 0b1             //laserCategory
    let weaponCategory:UInt32 = 0b1 << 1        //playerCategory
    let bugCategory:UInt32 = 0b1 << 2           //enemyCategory
    let bossCategory:UInt32 = 0b1 << 3          //itemCategory

    
    override func didMove(to view: SKView) {
        
        screenWidth = frame.width
        screenHeight = frame.height
        boss = self.childNode(withName: "boss") as! SKSpriteNode
        weapon = self.childNode(withName: "weapon") as! SKSpriteNode
        greenBug = self.childNode(withName: "greenBug") as! SKSpriteNode
        redBug = self.childNode(withName: "redBug") as! SKSpriteNode
        blueBug = self.childNode(withName: "blueBug") as! SKSpriteNode


        self.physicsWorld.contactDelegate = self
        
        // play background music
        let music = SKAudioNode(fileNamed: "spacemusic")
        self.addChild(music)
        music.autoplayLooped = true

        
        weapon = self.childNode(withName: "weapon") as? SKSpriteNode
        weapon?.physicsBody?.categoryBitMask = weaponCategory
        weapon?.physicsBody?.collisionBitMask = noCategory
        weapon?.physicsBody?.contactTestBitMask = bugCategory | bossCategory
        
        boss = self.childNode(withName: "boss") as? SKSpriteNode
        boss?.physicsBody?.categoryBitMask = bossCategory
        boss?.physicsBody?.collisionBitMask = noCategory
        boss?.physicsBody?.contactTestBitMask = weaponCategory
        
        redBug = self.childNode(withName: "redBug") as? SKSpriteNode
        redBug?.physicsBody?.categoryBitMask = bugCategory
        redBug?.physicsBody?.collisionBitMask = noCategory
        redBug?.physicsBody?.contactTestBitMask = bugCategory | bulletCategory

        
        self.weapon?.position = CGPoint(x: screenWidth! * 0.5, y: 0)

        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let explosion:SKEmitterNode = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = contact.bodyA.node!.position
        self.addChild(explosion)
        
        contact.bodyA.node?.removeFromParent()
        contact.bodyB.node?.removeFromParent()
    }

    
    func touchDown(atPoint pos : CGPoint) {
        self.weapon?.position = CGPoint(x: pos.x, y: 0)

        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        self.weapon?.position = CGPoint(x: pos.x, y: 0)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        self.weapon?.position = CGPoint(x: pos.x, y: 0)

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        //redBug?.physicsBody?.velocity = CGVector(dx: 25, dy: 0)
        
        checkBullet(currentTime - lastTime)
        lastTime = currentTime
        
//        if(ScoreManager.Lives > 0) {
//            livesLabel?.text = "Lives: \(ScoreManager.Lives)"
//            scoreLabel?.text = "Score: \(ScoreManager.Score)"
//        }
//        else {
//            if let view = self.view {
//                if let scene = SKScene(fileNamed: "GameOverScene") {
//                    scene.scaleMode = .aspectFit
//                    view.presentScene(scene)
//                }
//            }
//        }
        
        }
    
    

    
    func checkBullet(_ frameRate: TimeInterval)
    {
        // add time to timer
        timeSinceFire += frameRate
        
        // return if it hasn't been enough time to fire laser
        if timeSinceFire < fireRate {
            return
        }
        
        shootBullet()
        
        // reset timer
        timeSinceFire = 0
    }
    
    
    func shootBullet() {
        let scene:SKScene = SKScene(fileNamed: "Bullet")!
        let bullet = scene.childNode(withName: "bullet")
        bullet?.position = weapon!.position
        bullet?.move(toParent: self)
        bullet?.physicsBody?.categoryBitMask = bulletCategory
        bullet?.physicsBody?.collisionBitMask = noCategory
        bullet?.physicsBody?.contactTestBitMask = bugCategory
    }
    
    
}




