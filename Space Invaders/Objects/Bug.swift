/*
 * Bug.swift
 * Project: Space Invaders
 * Students:
 *          Irvinder Kaur           300929258
 *          Kamalpreet Singh        300976062
 *          Mehmet Fatih Inan       300966544
 *          Robert Argume           300949529
 *
 * Date: Mar 22, 2018
 * Description: Arcade game inspired on Space Invaders
 * Version: 0.1
 *     - Add class to manage Bugs
 */
import SpriteKit
import GameplayKit

class Bug: GameObject {
 
    // constructor
    init(imageString avatarName: String) {
        // initialize the object with an image
        super.init(imageString: avatarName, initialScale: 0.08)
        Start()
    }
    
    override init(imageString avatarName: String, initialScale scaleValue:CGFloat) {
        // initialize the object with an image and a scale value
        super.init(imageString: avatarName, initialScale: scaleValue)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func Start() {
        self.zPosition = 3
        self.Reset()
    }
    
    override func Reset() {
    }
    
    override func CheckBounds() {
    }
    
    override func Update() {
        self.position.x -= self.dx!
        
        let dyPercentile = (self.dy!.truncatingRemainder(dividingBy: 500))
        if (dyPercentile == 0) {
            self.position.y -= (self.dy! + 0.25)
        }
    }
    
}

