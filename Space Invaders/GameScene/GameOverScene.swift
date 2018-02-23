/*
 * GameOverScene.swift
 * Project: Space Invaders
 * Students:
 *          Irvinder Kaur           300929258
 *          Kamalpreet Singh        300976062
 *          Mehmet Fatih Inan       300966544
 *          Robert Argume           300949529
 *
 * Date: Mar 22, 2018
 * Description: Game over screen
 * Version: 0.1
 *     - Shows highest score and gives chance to start playing again
 */
import SpriteKit
import GameplayKit
import UIKit
import AVFoundation

class GameOverScene: SKScene {
    
   
    var gameOverLabel: Label?
    var pressAnyKeyLabel: Label?
    var hsLabel: Label?
    
    
    
    override func didMove(to view: SKView) {
       
        ScoreManager.UpdateHighscore()
        
        // add Game Over Label
        self.gameOverLabel = Label(labelString: "Game Over", position: CGPoint(x: frame.width * 0.5, y: frame.height * 0.5), fontSize: 60.0, fontName: "Dock51", fontColor: SKColor.yellow, isCentered: true)
        self.addChild(gameOverLabel!)
        
        // add Press Any Key Label
        self.pressAnyKeyLabel = Label(labelString: "Press Any Key to Restart", position: CGPoint(x: frame.width * 0.5, y: (frame.height * 0.5) - 50.0), fontSize: 25.0, fontName: "Dock51", fontColor: SKColor.yellow, isCentered: true)
        self.addChild(pressAnyKeyLabel!)
        
        // Highscore label
        self.hsLabel = Label(labelString: "Highscore: \(ScoreManager.getHighscore())", position: CGPoint(x: frame.width * 0.5, y: (frame.height * 0.5) - 100.0), fontSize: 25.0, fontName: "Dock51", fontColor: SKColor.yellow, isCentered: true)
        self.addChild(hsLabel!)
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











