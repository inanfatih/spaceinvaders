import SpriteKit
import UIKit

class ScoreManager {
    
    // Public Properties
    public static var Score:Int = 0
    
    public static var Lives:Int = 5
    
    private static var HIGHSCORE_KEY: String = "highscoreUserDefaults"
    public static func UpdateHighscore() {
        
        // Get User Defaults
        var highscore = UserDefaults.standard.integer(forKey: HIGHSCORE_KEY)
        
        print("highscore \(highscore)")
        print("score \(Score)")
        
        if (highscore == 0 || highscore < Score) {
            
            UserDefaults.standard.set(Score, forKey: HIGHSCORE_KEY)
            print("Congrats!! Highscore")
            
        }
    }
    
    public static func getHighscore() -> Int {
        
        var highscore = UserDefaults.standard.integer(forKey: HIGHSCORE_KEY)
        
        if (highscore < Score) {
            return Score            
        } else {
            return highscore
        }
    }
}
