/*
 * ScoreManager.swift
 * Project: Space Invaders
 * Students:
 *          Irvinder Kaur           300929258
 *          Kamalpreet Singh        300976062
 *          Mehmet Fatih Inan       300966544
 *          Robert Argume           300949529
 *
 * Date: Mar 22, 2018
 * Description: Manages scores, lives and highest score for the game
 *              Based on Professor Tom Tsiliopoulos code
 * Version: 0.1
 *     - Maintain basic score and lives
 * Version: 0.2
 *     - Mantain highest score
 */
import SpriteKit
import UIKit

class ScoreManager {
    
    // Public Properties
    public static var Score:Int = 0
    
    public static var Lives:Int = 5
    
    private static var HIGHSCORE_KEY: String = "highscoreUserDefaults"
    public static func UpdateHighscore() {
        
        // Get User Defaults
        let highscore = UserDefaults.standard.integer(forKey: HIGHSCORE_KEY)
        
        print("highscore \(highscore)")
        print("score \(Score)")
        
        if (highscore == 0 || highscore < Score) {
            
            UserDefaults.standard.set(Score, forKey: HIGHSCORE_KEY)
            print("Congrats!! Highscore")
            
        }
    }
    
    public static func getHighscore() -> Int {
        
        let highscore = UserDefaults.standard.integer(forKey: HIGHSCORE_KEY)
        
        if (highscore < Score) {
            return Score            
        } else {
            return highscore
        }
    }
}
