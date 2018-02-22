import SpriteKit
import GameplayKit
import UIKit

class YouWin: SKScene {

    
    var winScoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            winScoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
//        let scene:SKScene = SKScene(fileNamed: "YouWin")!
//        scoreLabel = scene.childNode(withName: "scoreLabel") as! SKLabelNode
//        scoreLabel.text = "Your Score: \(ScoreManager.Score)"
//
        
        // add score label
        winScoreLabel = Label(labelString: "Your Score: \(ScoreManager.Score)", position: CGPoint(x: frame.width * 0.45, y: frame.height - 300.0), fontSize: 30.0, fontName: "Dock51", fontColor: SKColor.blue, isCentered: false)
        winScoreLabel.zPosition = 10
        self.addChild(winScoreLabel!)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches {
            let positionInScene = t.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if let name = touchedNode.name
            {
                if name == "mainMenuLabel2"
                {
                    if let view = self.view {
                        if let scene = SKScene(fileNamed: "MainMenu") {
                            scene.scaleMode = .aspectFit
                            view.presentScene(scene)
                        }
                    }
                }
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


