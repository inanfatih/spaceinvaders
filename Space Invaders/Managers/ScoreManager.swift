import SpriteKit
import UIKit

class ScoreManager {
    
    // Public Properties
    public static var Score:Int = 0
    
    public static var Lives:Int = 5
    
    public static var HighScore: Int = 0
    
    private static var HIGHSCORE_KEY: String = "highscoreUserDefaults"
    public static func UpdateHighscore() {
        
        // Get User Defaults
        var highscore = UserDefaults.standard.integer(forKey: HIGHSCORE_KEY)
        
        if (highscore == 0 || highscore < Score) {
            
            UserDefaults.standard.set(Score, forKey: "Key")
            
        }
    }
}