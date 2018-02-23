/*
 * GameObject.swift
 * Project: Space Invaders
 * Students:
 *          Irvinder Kaur           300929258
 *          Kamalpreet Singh        300976062
 *          Mehmet Fatih Inan       300966544
 *          Robert Argume           300949529
 *
 * Date: Mar 22, 2018
 * Description: Defines a Game object. Inherits from Sprite Kit Node and implemnents our game protocol
 *              Based on Professor Tom Tsiliopoulos code
 * Version: 0.1
 *     - Established properties for managing game objects along the game
 */

import SpriteKit
import GameplayKit

class GameObject: SKSpriteNode, GameProtocol {
    // Instance Variables
    var dx: CGFloat?
    var dy: CGFloat?
    var width: CGFloat?
    var height: CGFloat?
    var halfwidth: CGFloat?
    var halfheight: CGFloat?
    var scale: CGFloat?
    var isColliding: Bool?
    var randomSource: GKARC4RandomSource?
    var randomDist: GKRandomDistribution?
    
    // Constructor
    init(imageString: String, initialScale: CGFloat) {
        // Initialize the object with an image
        let texture = SKTexture(imageNamed: imageString)
        let color = UIColor.clear
        super.init(texture: texture, color: color, size: texture.size())
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.scale = initialScale
        self.setScale(scale!)
        self.width = texture.size().width * self.scale!
        self.height = texture.size().height * self.scale!
        self.halfwidth = self.width! * 0.5;
        self.halfheight = self.height! * 0.5;
        self.isColliding = false
        self.name = imageString
        randomSource = GKARC4RandomSource()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func Reset() {
        
    }
    
    public func CheckBounds() {
        
    }
    
    public func Start() {
        
    }
    
    public func Update() {
        
    }
    
    
    
}

