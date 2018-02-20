import SpriteKit
import GameplayKit
import UIKit
import AVFoundation

class GameOverScene: SKScene {
    
   
    var gameOverLabel: Label?
    var pressAnyKeyLabel: Label?
    
    
    
    override func didMove(to view: SKView) {
       
        // add Game Over Label
        self.gameOverLabel = Label(labelString: "Game Over", position: CGPoint(x: frame.width * 0.5, y: frame.height * 0.5), fontSize: 60.0, fontName: "Dock51", fontColor: SKColor.yellow, isCentered: true)
        self.addChild(gameOverLabel!)
        
        // add Press Any Key Label
        self.pressAnyKeyLabel = Label(labelString: "Press Any Key to Restart", position: CGPoint(x: frame.width * 0.5, y: (frame.height * 0.5) - 50.0), fontSize: 25.0, fontName: "Dock51", fontColor: SKColor.yellow, isCentered: true)
        self.addChild(pressAnyKeyLabel!)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        
        ScoreManager.Lives = 5
        ScoreManager.Score = 0
        
        if let view = self.view {
            if let scene = SKScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFit
                view.presentScene(scene)
            }
        }
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
        
    }
}











