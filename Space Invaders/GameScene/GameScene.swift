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
    
    
//    var redBug2: SKSpriteNode?
//    var redBug3: SKSpriteNode?
//    var redBug4: SKSpriteNode?
//    var redBug5: SKSpriteNode?
//    var redBug6: SKSpriteNode?
//    var redBug7: SKSpriteNode?
//    var redBug8: SKSpriteNode?
    
    
    var fireRate:TimeInterval = 0.5
    var timeSinceFire:TimeInterval = 0
    var lastTime:TimeInterval = 0
    
    override func didMove(to view: SKView) {
        
        screenWidth = frame.width
        screenHeight = frame.height
        boss = self.childNode(withName: "boss") as! SKSpriteNode
        weapon = self.childNode(withName: "weapon") as! SKSpriteNode
        greenBug = self.childNode(withName: "greenBug") as! SKSpriteNode
        redBug = self.childNode(withName: "redBug") as! SKSpriteNode
        blueBug = self.childNode(withName: "blueBug") as! SKSpriteNode


//        redBug2 = self.childNode(withName: "redBug2") as? SKSpriteNode
//        redBug3 = self.childNode(withName: "redBug3") as? SKSpriteNode
//        redBug4 = self.childNode(withName: "redBug4") as? SKSpriteNode
//        redBug5 = self.childNode(withName: "redBug5") as? SKSpriteNode
//        redBug6 = self.childNode(withName: "redBug6") as? SKSpriteNode
//        redBug7 = self.childNode(withName: "redBug7") as? SKSpriteNode
//        redBug8 = self.childNode(withName: "redBug8") as? SKSpriteNode

        self.physicsWorld.contactDelegate = self
        
        // play background music
        let music = SKAudioNode(fileNamed: "spacemusic")
        self.addChild(music)
        music.autoplayLooped = true
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        <#code#>
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        self.weapon?.position = CGPoint(x: pos.x, y: 50.0)

        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        self.weapon?.position = CGPoint(x: pos.x, y: 50.0)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        self.weapon?.position = CGPoint(x: pos.x, y: 50.0)

        
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
    }
    
    
}




