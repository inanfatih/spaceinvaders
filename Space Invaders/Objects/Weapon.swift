//
//  Plane.swift
//  MAPD724-W2018-Lesson2
//
//  Created by Tom Tsiliopoulos on 2018-01-29.
//  Copyright © 2018 Centennial College. All rights reserved.
//

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

