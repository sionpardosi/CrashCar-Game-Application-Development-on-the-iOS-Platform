import UIKit
import SpriteKit

class GameOverScene: SKScene {
    
    var gameOverLabel: SKLabelNode!
    var restartLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        restartLabel = self.childNode(withName: "//restartLabel") as? SKLabelNode
        
        // latar belakang
        backgroundColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 1.0)
        
        // Teks game over
        gameOverLabel = SKLabelNode(text: "GAME OVER")
        gameOverLabel.fontSize = 50
        gameOverLabel.fontColor = UIColor.white
        gameOverLabel.fontName = "Arial-BoldMT"
        gameOverLabel.position = CGPoint.zero
        gameOverLabel.zPosition = 1
        addChild(gameOverLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        if self.atPoint(location) == restartLabel {
            restartGame()
        }
    }
    
    func restartGame() {
        if let scene = SKScene(fileNamed: "GameScene") {
            scene.scaleMode = .aspectFill
            
            let transition = SKTransition.doorway(withDuration: 1)
            view?.presentScene(scene, transition: transition)
        }
    }
}


