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
    var moveDirection: String = "left"
    
    // constructor
    init(imageString avatarName: String) {
        // initialize the object with an image
        super.init(imageString: avatarName, initialScale: 0.08)
        Start()
    }
    
    override init(imageString avatarName: String, initialScale scaleValue:CGFloat) {
        // initialize the object with an image
        super.init(imageString: avatarName, initialScale: scaleValue)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func Start() {
        self.zPosition = 3
        self.Reset()
        //self.dy = 0.0
    }
    
    override func Reset() {
//        self.position.y = 700 + self.height!;
//        let randomX:Int = (randomSource?.nextInt(upperBound: Int(screenWidth! - self.width!)))! + Int(self.halfwidth!)
//        self.position.x = CGFloat(randomX)
//        self.dy = CGFloat(((randomSource?.nextUniform())! * 5.0) + 5.0)
//        self.dx = CGFloat(((randomSource?.nextUniform())! * -4.0) + 2.0)
        self.dx = 1.0
        self.dy = 0.0
    }
    
    override func CheckBounds() {
//        if(self.position.x < (self.width!)/2) {
//            self.dx = -1.0
//            moveDirection = "right"
//        }
//        if((screenSize.width - self.position.x) < (self.width!)/2) {
//            self.dx = 1.0
//            moveDirection = "left"
//        }
    }
    
    override func Update() {
        //self.position.y -= self.dy!
        //self.position.x -= self.dx!
        //self.CheckBounds()
        
//        if(moveDirection == "left") {
//            self.position.x -= self.dx!
//        }
//        else {
//            self.position.x += self.dx!
//        }
//        self.CheckBounds()
    }
    
}

