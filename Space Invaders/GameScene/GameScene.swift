

import SpriteKit
import GameplayKit
import CoreMotion
import AVFoundation

let screenSize = UIScreen.main.bounds
var screenWidth: CGFloat?

var screenHeight: CGFloat?
var motionManager = CMMotionManager()
var destX:CGFloat  = 0.0

var Ground = SKSpriteNode()

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    var boss: SKSpriteNode?
    var weapon: SKSpriteNode?
    var greenBug: SKSpriteNode?
    var redBug: SKSpriteNode?
    var blueBug: SKSpriteNode?
    var bullet: SKSpriteNode?
    var livesLabel: Label?
//    var scoreLabel: Label?
    
    var fireRate:TimeInterval = 0.5
    var timeSinceFire:TimeInterval = 0
    var lastTime:TimeInterval = 0
    
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    let motionManger = CMMotionManager()
    var xAcceleration:CGFloat = 0
    
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

        //preload sounds to prevent delays
        do {
            let sounds:[String] = ["explosion","laser"]
            for sound in sounds {
                let path:String = Bundle.main.path(forResource: sound, ofType: "wav")!
                let url:URL = URL(fileURLWithPath: path)
                let player:AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
            }
        } catch {
            
        }
        
        // play background music
        let music = SKAudioNode(fileNamed: "music.m4a")
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

        
        self.weapon?.position = CGPoint(x: screenWidth! * 0.5, y: 25)

        // add score label
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 100, y: self.frame.size.height - 30)
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = UIColor.white
        score = 0
        
        self.addChild(scoreLabel)

        
        // add lives label
        livesLabel = Label(labelString: "Lives: 5", position: CGPoint(x: 300, y: frame.height - 20.0), fontSize: 30.0, fontName: "Dock51", fontColor: SKColor.white, isCentered: false)
        self.addChild(livesLabel!)
        
        motionManger.accelerometerUpdateInterval = 0.2
        motionManger.startAccelerometerUpdates(to: OperationQueue.current!) { (data:CMAccelerometerData?, error:Error?) in
            if let accelerometerData = data {
                let acceleration = accelerometerData.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.75 + self.xAcceleration * 0.25
            }
        }
    }

    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let explosion:SKEmitterNode = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = contact.bodyA.node!.position
        self.addChild(explosion)
        
        //play explosion music when hit
        self.run(SKAction.playSoundFileNamed("explosion", waitForCompletion: false))
        
        contact.bodyA.node?.removeFromParent()
        contact.bodyB.node?.removeFromParent()
    }

    
    func touchDown(atPoint pos : CGPoint) {
        self.weapon?.position = CGPoint(x: pos.x, y: 25)

        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        self.weapon?.position = CGPoint(x: pos.x, y: 25)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        self.weapon?.position = CGPoint(x: pos.x, y: 25)

        
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
        
        
        // Update Labels
        if(ScoreManager.Lives > 0) {
            livesLabel?.text = "Lives: \(ScoreManager.Lives)"
            scoreLabel?.text = "Score: \(ScoreManager.Score)"
        }
        else {
            if let view = self.view {
                if let scene = SKScene(fileNamed: "GameOverScene") {
                    scene.scaleMode = .aspectFit
                    view.presentScene(scene)
                }
            }
        }
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
        
        //play explosion music when hit
        self.run(SKAction.playSoundFileNamed("laser", waitForCompletion: false))
        
        //remove bullets after 1 sec. to decrease number of nodes
        let waitAction = SKAction.wait(forDuration: 1.0)
        let removeAction = SKAction.removeFromParent()
        bullet?.run(SKAction.sequence([waitAction,removeAction]))
    
    }
    
}




