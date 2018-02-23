/*
 * Weapon.swift
 * Project: Space Invaders
 * Students:
 *          Irvinder Kaur           300929258
 *          Kamalpreet Singh        300976062
 *          Mehmet Fatih Inan       300966544
 *          Robert Argume           300949529
 *
 * Date: Mar 22, 2018
 * Description: Defines game object for our defender hero
 * Version: 0.1
 *     - Establishes initialization and boundaries of movement
 */
import SpriteKit

class Weapon: GameObject {
    
    // constructor
    init() {
        super.init(imageString: "weapon", initialScale: 1.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func CheckBounds() {
        // right boundary
        if(self.position.x > screenSize.width - self.halfwidth!) {
            self.position.x = screenSize.width - self.halfwidth!
        }
        
        // left boundary
        if(self.position.x < self.halfwidth!) {
            self.position.x = self.halfwidth!
        }
    }
    
    override func Start() {
        self.zPosition = 2
    }
    
    override func Update() {
        self.CheckBounds()
    }
    
    func TouchMove(newPos: CGPoint) {
        self.position = newPos
    }
    
}

