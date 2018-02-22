
import UIKit
import SpriteKit
import GameplayKit


class MainMenu: SKScene {
    
    var hsLabel: Label?
    
    override func didMove(to view: SKView) {
        
        // Highscore label
        self.hsLabel = Label(labelString: "Highscore: \(ScoreManager.getHighscore())", position: CGPoint(x: frame.width * 0.5, y: (frame.height * 0.5) - 200.0), fontSize: 50.0, fontName: "Dock51", fontColor: SKColor.yellow, isCentered: true)
        self.addChild(hsLabel!)
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
                if name == "InstructionsButton"
                {
                    if let view = self.view {
                        if let scene = SKScene(fileNamed: "InstructionsScene") {
                            scene.scaleMode = .aspectFit
                            view.presentScene(scene)
                        }
                    }
                }
            }
            else{
                ScoreManager.Lives = 5
                ScoreManager.Score = 0
                
                if let view = self.view {
                    if let scene = SKScene(fileNamed: "GameScene") {
                        scene.scaleMode = .aspectFit
                        view.presentScene(scene)
                    }
                }
            }
            //self.touchDown(atPoint: t.location(in: self))
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
