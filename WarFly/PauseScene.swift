//
//  PauseScene.swift
//  WarFly
//
//  Created by Yuliia Stelmakhovska on 2017-09-05.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import SpriteKit

class PauseScene: ParentScene {
    
    
    override func didMove(to view: SKView) {
        
              
        //        let header = ButtonNode(titled: "pause", backgroundName: "header_background")
        //        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY+150)
        //        self.addChild(header)
        
        
        setHeader(withName: "pause", andBackground:"header_background")
        
        
        let titles = ["restart", "options", "resume"]
        
        for (index, title) in titles.enumerated() {
            
            let button = ButtonNode(titled: title, backgroundName: "button_background")
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(index * 100))
            button.name = title
            button.label.name = title
            addChild(button)
        }
    }
    //    updates 60 times per sec to prevent bug with pause
    override func update(_ currentTime: TimeInterval) {
        if let gameScene = sceneManager.gameScene{
            if gameScene.isPaused == false{
                gameScene.isPaused = true
                print("!!!!CHANGED TO PAUSED")
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        first touch inside the scene
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "restart"{
            sceneManager.gameScene = nil
            let transition  = SKTransition.crossFade(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        }
        else if node.name == "resume"{
            
            let transition  = SKTransition.crossFade(withDuration: 1.0)
            guard let gameScene = sceneManager.gameScene else { return }
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        }
            
        else if node.name == "options"{
            
            let transition  = SKTransition.crossFade(withDuration: 1.0)
            let optionsScene = OptionsScene(size: self.size)
            optionsScene.backScene = self
            optionsScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(optionsScene, transition: transition)
        }
        
    }
}
