/*
 * Label.swift
 * Project: Space Invaders
 * Students:
 *          Irvinder Kaur           300929258
 *          Kamalpreet Singh        300976062
 *          Mehmet Fatih Inan       300966544
 *          Robert Argume           300949529
 *
 * Date: Mar 22, 2018
 * Description: Wraper class to manage Sprite Kit label node
 * Version: 0.1
 *     - Establishes initialization properties and position
 */

import SpriteKit
import CoreGraphics


class Label: SKLabelNode {
    // Private Instance Variables
    
    // Public Properties
    
    // Constructors
    init(labelString:String,
         position:CGPoint,
         fontSize:CGFloat,
         fontName:String,
         fontColor: SKColor,
         isCentered:Bool) {
        super.init()
        
        self.text = labelString
        
        self.fontSize = fontSize
        self.fontName = fontName
        self.fontColor = fontColor
        
        if(isCentered) {
            self.position = position
        }
        else {
            self.position.x = position.x + self.frame.width * 0.5
            self.position.y = position.y - self.frame.height * 0.5
        }
        
        self.zPosition = 10
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}

