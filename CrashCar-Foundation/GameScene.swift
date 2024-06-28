//
//  GameScene.swift
//  CrashCar-Foundation
//
//  Created by Foundation-014 on 27/06/24.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    var cone: SKSpriteNode?
    var car: SKSpriteNode?
    var hpLabel: SKLabelNode?
    
    let xPosition = [90, -90]
    var carPosition = 1
    
    var hp = "❤️❤️❤️"
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        // register swhipe gesture
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)

        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        cone = self.childNode(withName: "//cone") as? SKSpriteNode
        
        car = self.childNode(withName: "//car") as? SKSpriteNode
        car?.physicsBody = SKPhysicsBody(rectangleOf: car?.size ?? .zero)
        car?.physicsBody?.affectedByGravity = false
        car?.physicsBody?.allowsRotation = false
        car?.physicsBody?.contactTestBitMask = car?.physicsBody?.collisionBitMask ?? 0
        
        // programmitacally setup label
        hpLabel = SKLabelNode(text: "\(hp)")
        hpLabel?.position = CGPoint(x: 200, y: (size.height/2 - 50))
        addChild(hpLabel!)
        
        repeatedlySpawnCone()
        
    }
    
    // FUNC
    
    func repeatedlySpawnCone(){
        let spawnAction = SKAction.run {
            self.spawnCone()
        }
        
        let waitAction = SKAction.wait(forDuration: 2)
        
        let spawnAndWaitAction = SKAction.sequence([spawnAction, waitAction])

        run(SKAction.repeatForever(spawnAndWaitAction))
    }
    
    func spawnCone(){
        let newCone = cone?.copy() as! SKSpriteNode
        
        newCone.position = CGPoint(x: xPosition[Int.random(in: 0...1)], y: 700)
        newCone.physicsBody = SKPhysicsBody(rectangleOf: newCone.size)
        newCone.physicsBody?.isDynamic = false
        
        addChild(newCone)
        
//        hilangkan berdasarkan cone yang ditambahkan
        moveCone(node: newCone)
    }
    
    func moveCone(node: SKNode){
        let moveDownAction = SKAction.moveTo(y: -700, duration: 4)
        
        //removecone
        let removeNodeAction = SKAction.removeFromParent()
        
        node.run(SKAction.sequence([moveDownAction, removeNodeAction]))
    }
    
    func updateCarPosition(){
//        condition
//        if carPosition == 1 {
//            carPosition = 2
//        } else {
//            carPosition = 1
//        }
        
        car?.run(SKAction.moveTo(x: (carPosition == 1) ? -80 : 80, duration: 0.1))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        update car position
//        updateCarPosition()
    }

    
    @objc func swipeRight(){
        carPosition = 2
        updateCarPosition()
    }
    
    @objc func swipeLeft(){
        carPosition = 1
        updateCarPosition()
    }
    
    // function yang menghandle kontak 2 node
    func didBegin(_ contact: SKPhysicsContact) {
        
        guard let nodeA = contact.bodyA.node else {
            return
        }
        guard let nodeB = contact.bodyB.node else {
            return
        }
        
        // handle collision only between car and cone
        if nodeA.name == "car" && nodeB.name == "cone" {
            nodeB.removeFromParent()
            
            if hp.count > 0 {
                hp.removeLast()
            }
            
            // update hpLabel text if there is collision
            hpLabel?.text = "\(hp)"
    
            if hp.count == 0 {
                showGameOver()
            }
        }
    }
    
    // Menampilkan layar game over
    func showGameOver() {
        
        if let gameOverScene = SKScene(fileNamed: "GameOverScene") {
            // Tentukan transisi
            let transition = SKTransition.fade(withDuration: 1.0)
            
            // Transisi ke GameOverScene
            view?.presentScene(gameOverScene, transition: transition)
        }
        
        /*
        // Buat instance GameOverScene
        let gameOverScene = GameOverScene(size: size)
        
        // Tentukan transisi
        let transition = SKTransition.fade(withDuration: 1.0)
        
        // Transisi ke GameOverScene
        view?.presentScene(gameOverScene, transition: transition)
         
         */
    }

}


