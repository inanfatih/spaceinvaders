/*
 * BugLine.swift
 * Project: Space Invaders
 * Students:
 *          Irvinder Kaur           300929258
 *          Kamalpreet Singh        300976062
 *          Mehmet Fatih Inan       300966544
 *          Robert Argume           300949529
 *
 * Date: Mar 22, 2018
 * Description: Game object that help managing one single line of enemies
 * Version: 0.1
 *     - Management of update position for a line of enemies
 */
import SpriteKit
import GameplayKit

class BugLine: GameObject {
    
    // Variables that will help manage group movement
    var groupDx: CGFloat?
    var currentLineY: Double?
    var bugs: [Bug] = []
    var landed:Bool = false
    
    // constructor
    init() {
        // initialize the object with an image
        super.init(imageString: "", initialScale: 1)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func Start() {
        self.groupDx = velocityX
        self.currentLineY = 0
        self.zPosition = 3
        self.Reset()
    }
    
    override func Reset() {
    }
    
    func Append(_ aBug:Bug){
        self.bugs.append(aBug)
    }
    
    override func CheckBounds() {
        // if left bound is reached, change direction to the right
        if(bugs[0].position.x < (bugs[0].width!)/2) {
            self.groupDx = -velocityX
            self.currentLineY =  separationY
        }
        // if right bound is reached, change direction to the left
        else if((screenSize.width - bugs[bugs.count-1].position.x) < (bugs[bugs.count-1].width!)/2) {
            self.groupDx = velocityX
            self.currentLineY =  separationY
        }
        else {
            self.currentLineY = 0
        }
    }
    
    override func Update() {
        for bug in bugs{
            bug.dx = self.groupDx
            bug.dy = CGFloat(self.currentLineY!)
            bug.Update()
        }
        
        self.landed = (bugs[0].position.y <= 0)
        
        self.CheckBounds()
    }
    
}


