

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
    
    // variables to manage game nodes
    var boss: SKSpriteNode?
    var aBug: SKSpriteNode?
    var weapon: SKSpriteNode?
    var bullet: SKSpriteNode?
  
    var bugsSprites: [BugLine] = []
     var defenseBlocks: [SKSpriteNode?] = []
    
    // variables to manage labels
    var livesLabel: Label?
    var standByLabel: Label?
    
    // variables to manage shooting frequency
    var fireRate:TimeInterval = 0.5
    var timeSinceFire:TimeInterval = 0
    var lastTime:TimeInterval = 0
    var stopHeroShooting = false;
    
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    // setup accelerometer
    let motionManger = CMMotionManager()
    var xAcceleration:CGFloat = 0
    
    // Setup masks for contact detection
    let noCategory:UInt32 = 0
    let bulletCategory:UInt32 = 0b1             //laserCategory
    let weaponCategory:UInt32 = 0b1 << 1        //playerCategory
    let bugCategory:UInt32 = 0b1 << 2           //enemyCategory
    let bossCategory:UInt32 = 0b1 << 3          //itemCategory
    let bugBulletCategory:UInt32 = 0b1 << 4          //bugBulletCategory
    let defenseCategory:UInt32 = 0b1 << 5          //defenseCategory

    
    override func didMove(to view: SKView) {
        // To allow Physics contact delegate to work
        self.physicsWorld.contactDelegate = self
        
        screenWidth = frame.width
        screenHeight = frame.height
        boss = (self.childNode(withName: BossNodeName) as! SKSpriteNode)
        weapon = (self.childNode(withName: DefenderName) as! SKSpriteNode)
        
        // Variable that help to change avatar and scale for each group of bugs
        var currentGroup = -1
        
        // Set up enemies
        for row in 0...numberOfRows-1 {
            let changeY: Double = separationY * Double(row)
            let newPositionY = firstRowPositionY + changeY
            // Every 2 lines, we change the bug avatar
            if row % 3 == 0 {
                currentGroup = currentGroup + 1
            }
            bugsSprites.append(BugLine());
            for index in 0...enemiesPerRow-1 {
                let bug: Bug = Bug(imageString: avatars[currentGroup], initialScale: CGFloat(scales[currentGroup]))
                bug.name = BugNodeName
                let changeX: Double = separationX * Double(index)
                let newPositionX = firstRowPositionX + changeX
                bug.position = CGPoint(x:newPositionX, y: newPositionY)
                bugsSprites[row].Append(bug)
                self.addChild(bug)
                
                // Set up contact detection for each bug
                bug.physicsBody?.categoryBitMask = bugCategory
                bug.physicsBody?.collisionBitMask = noCategory
                bug.physicsBody?.contactTestBitMask = bulletCategory | weaponCategory
            }
        }

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
        
        // setup contact detection for our hero
        weapon = self.childNode(withName: DefenderName) as? SKSpriteNode
        weapon?.physicsBody?.categoryBitMask = weaponCategory
        weapon?.physicsBody?.collisionBitMask = noCategory
        weapon?.physicsBody?.contactTestBitMask = bugCategory | bossCategory | bugBulletCategory
        
        // setup contact detection for the boss ship
        boss = self.childNode(withName: BossNodeName) as? SKSpriteNode
        boss?.physicsBody?.categoryBitMask = bossCategory
        boss?.physicsBody?.collisionBitMask = noCategory
        boss?.physicsBody?.contactTestBitMask = weaponCategory
        
        // setup contact detection for the defense blocks
        defenseBlocks.append(self.childNode(withName: DefenseBlockLeft) as? SKSpriteNode)
        defenseBlocks.append(self.childNode(withName: DefenseBlockCenter) as? SKSpriteNode)
        defenseBlocks.append(self.childNode(withName: DefenseBlockRight) as? SKSpriteNode)
        for block in defenseBlocks {
            block?.physicsBody?.categoryBitMask = defenseCategory
            block?.physicsBody?.collisionBitMask = noCategory
            block?.physicsBody?.contactTestBitMask = bugBulletCategory
        }
        
        // initial position of our defender hero
        self.weapon?.position = CGPoint(x: screenWidth! * 0.5, y: 25)
     
        // add lives label
        livesLabel = Label(labelString: "Lives: 5", position: CGPoint(x: 20.0, y: frame.height - 20.0), fontSize: 30.0, fontName: "Dock51", fontColor: SKColor.yellow, isCentered: false)
        self.addChild(livesLabel!)
        
        // add score label
        scoreLabel = Label(labelString: "Score: 0", position: CGPoint(x: frame.width * 0.45, y: frame.height - 20.0), fontSize: 30.0, fontName: "Dock51", fontColor: SKColor.yellow, isCentered: false)
        self.addChild(scoreLabel!)
        
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
        
        // Logic applied when one bug is destroyed by our hero
        if contact.bodyA.node?.name == BugNodeName || contact.bodyB.node?.name == BugNodeName {
            ScoreManager.Score += PointsForBug
            scoreLabel.text = "Score: \(ScoreManager.Score)"
        }
        
        // Logic applied when one bug is destroyed by our hero
        if contact.bodyA.node?.name == BossNodeName || contact.bodyB.node?.name == BossNodeName {
            ScoreManager.Score += PointsForBoss
            scoreLabel.text = "Score: \(ScoreManager.Score)"
            
            if let view = self.view {
                if let scene = SKScene(fileNamed: "YouWin") {
                    scene.scaleMode = .aspectFit
                    view.presentScene(scene)
                }
            }
            
        }
        
        // Logic applied when our hero is destroyed by bugs bullets
        if contact.bodyA.node?.name == DefenderName || contact.bodyB.node?.name == DefenderName {
            // If one of the collision involves our hero, then decrease his lives and apply logic to continue playing
            ScoreManager.Lives -= 1
            
            if ScoreManager.Lives > 0 {
                // Setup delay and condition to wait until next hero live is in play
                stopHeroShooting = true
                let delay = SKAction.wait(forDuration: 3.0)
                
                // Show a label, so the user knows he need to wait 3 seconds to continue playing
                standByLabel = Label(labelString: "Continue in 3 seconds!", position: CGPoint(x: screenWidth! * 0.5, y: frame.height - 80.0), fontSize: 38.0, fontName: "Dock51", fontColor: SKColor.white, isCentered: true)
                self.addChild(standByLabel!)
                
                self.run(delay) {
                    self.standByLabel?.removeFromParent()
                    self.stopHeroShooting = false
                    let texture = SKTexture(imageNamed: DefenderName)
                    self.weapon = SKSpriteNode(texture: texture, size: texture.size())
                    self.weapon?.name = DefenderName
                    
                    // Setup scale for image
                    self.weapon?.setScale(CGFloat(0.15))
                    
                    // initial position of our defender hero
                    self.weapon?.position = CGPoint(x: screenWidth! * 0.5, y: 25)
                    self.addChild(self.weapon!)
                    
                    // setup contact detection for our hero
                    self.weapon?.physicsBody = SKPhysicsBody(rectangleOf: (self.weapon?.frame.size)!)
                    self.weapon?.physicsBody!.isDynamic = true
                    self.weapon?.physicsBody!.affectedByGravity = false
                    self.weapon?.physicsBody?.categoryBitMask = self.weaponCategory
                    self.weapon?.physicsBody?.collisionBitMask = self.noCategory
                    self.weapon?.physicsBody?.contactTestBitMask = self.bugCategory | self.bossCategory | self.bugBulletCategory
                    
                }
                
            }
        }
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
        
        // Check if bugs touches land. In that case, player has lost the game
        for bugLine in bugsSprites {
            if bugLine.landed {
                if let view = self.view {
                    if let scene = SKScene(fileNamed: "GameOverScene") {
                        scene.scaleMode = .aspectFit
                        view.presentScene(scene)
                    }
                }
            }
        }
        
        // Shoot defender bullets at a fixed rate
        checkBullet(currentTime - lastTime)
        lastTime = currentTime
        
        // Updates enemies positions
        for bugLine in bugsSprites {
            bugLine.Update()
        }
        
        // Update Labels and if the player has no more lives, then he/she has lost the game
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
        
        // Shoot bug bullets
        fireBugBullets(forUpdate: currentTime)
    }
    
    func checkBullet(_ frameRate: TimeInterval)
    {
        // add time to timer
        timeSinceFire += frameRate
        
        // return if it hasn't been enough time to fire laser
        if timeSinceFire < fireRate {
            return
        }
        
        if stopHeroShooting {
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
        bullet?.physicsBody?.contactTestBitMask = bossCategory | bugCategory
        
        //play explosion music when hit
        self.run(SKAction.playSoundFileNamed("laser", waitForCompletion: false))
        
        //remove bullets after 1 sec. to decrease number of nodes
        let waitAction = SKAction.wait(forDuration: 1.0)
        let removeAction = SKAction.removeFromParent()
        bullet?.run(SKAction.sequence([waitAction,removeAction]), withKey: DefenderBulletAction)
    }
    
    func fireBugBullets(forUpdate currentTime: CFTimeInterval) {
        // First we check if bug bullet already exist
        let existingBullet = childNode(withName: BugBulletName)
        
        if existingBullet == nil {
            var allBugs = [SKNode]()
            
            // Get all bugs currently existing in the scene
            enumerateChildNodes(withName: BugNodeName) { node, stop in
                allBugs.append(node)
            }
            
            if allBugs.count > 0 {
                // Decide on bug randomly
                let randomIndex = Int(arc4random_uniform(UInt32(allBugs.count)))
                let oneBug = allBugs[randomIndex]
                
                // Create the bullet and the destination (bottom edge of the screen)
                let bullet: SKSpriteNode = SKSpriteNode(color: SKColor.magenta, size: BulletSize)
                bullet.name = BugBulletName
                bullet.position = CGPoint(
                    x: oneBug.position.x,
                    y: oneBug.position.y - oneBug.frame.size.height / 2 + bullet.frame.size.height / 2
                )
                let bulletDestination = CGPoint(x: oneBug.position.x, y: -(bullet.frame.size.height / 2))
               
                // Set up contact detection for this bullet
                bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.frame.size)
                bullet.physicsBody!.isDynamic = true
                bullet.physicsBody!.affectedByGravity = false
                bullet.physicsBody?.categoryBitMask = bugBulletCategory
                bullet.physicsBody?.collisionBitMask = noCategory
                bullet.physicsBody?.contactTestBitMask = weaponCategory
                
                // Fire the buttlet using actions
                fireBugBullet(
                    bullet: bullet,
                    toDestination: bulletDestination,
                    withDuration: 0.5,
                    andSoundFileName: "laser.wav"
                )
            }
        }
    }
    
    func fireBugBullet(bullet: SKNode, toDestination destination: CGPoint, withDuration duration: CFTimeInterval, andSoundFileName soundName: String) {
        // Create an action sequence to simulte the bullet movement
        let bulletAction = SKAction.sequence([
            SKAction.move(to: destination, duration: duration),
            SKAction.wait(forDuration: 3.0 / 60.0),
            SKAction.removeFromParent()
            ])
        // setup sound, run the bullet and add it to the scene
        let soundAction = SKAction.playSoundFileNamed(soundName, waitForCompletion: true)
        bullet.run(SKAction.group([bulletAction, soundAction]))
        addChild(bullet)
    }
    
}




