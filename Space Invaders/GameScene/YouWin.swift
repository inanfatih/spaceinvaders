/*
 * YouWin.swift
 * Project: Space Invaders
 * Students:
 *          Irvinder Kaur           300929258
 *          Kamalpreet Singh        300976062
 *          Mehmet Fatih Inan       300966544
 *          Robert Argume           300949529
 *
 * Date: Mar 22, 2018
 * Description: Screen that is shown when the player wins the game
 * Version: 0.1
 *     - Shows congratulation image, highest score, and gives chance to go to main menu
 */
import SpriteKit
import GameplayKit
import UIKit

class YouWin: SKScene {

    
    var currentScoreLabel:Label!
   
    
    override func didMove(to view: SKView) {

        
        self.currentScoreLabel = Label(labelString: "Your Score: \(ScoreManager.Score)", position: CGPoint(x: frame.width * 0.5, y: (frame.height * 0.5) - 200.0), fontSize: 50.0, fontName: "Dock51", fontColor: SKColor.black, isCentered: true)
        self.addChild(currentScoreLabel!)
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


