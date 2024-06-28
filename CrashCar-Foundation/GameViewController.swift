//
//  GameViewController.swift
//  CrashCar-Foundation
//
//  Created by Foundation-024 on 27/06/24.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: true)

        if let view = self.view as! SKView? {
            
            if let scene = SKScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
            view.showsNodeCount = true
            view.showsFPS = true
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
//    override var prefersStatusBarHidden: Bool{
//        
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
