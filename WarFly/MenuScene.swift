//
//  MenuScene.swift
//  WarFly
//
//  Created by Yuliia Stelmakhovska on 2017-08-29.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import SpriteKit

class MenuScene: ParentScene {
    
    override func didMove(to view: SKView) {
        if !Assets.shared.isLoaded{
            Assets.shared.preloadAssets()
            Assets.shared.isLoaded = true
        }
   
        //        let texture = SKTexture(imageNamed: "play")
        //        let button = SKSpriteNode(texture: texture)
        //        button.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        //        button.name = "runButton"
        //        self.addChild(button)
        
        //              let header = SKSpriteNode(imageNamed: "header1")
        //        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY+150)
        //         self.addChild(header)
        //
        setHeader(withName: nil, andBackground:"header1")
        
        
        let titles = ["play", "options", "best"]
        
        for (index, title) in titles.enumerated() {
            
            let button = ButtonNode(titled: title, backgroundName: "button_background")
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(index * 100))
            button.name = title
            button.label.name = title
            addChild(button)
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        first touch inside the scene
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "play"{
            let transition  = SKTransition.crossFade(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
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
        else if node.name == "best"{
            
            let transition  = SKTransition.crossFade(withDuration: 1.0)
            let bestScene = BestScene(size: self.size)
            bestScene.backScene = self
            bestScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(bestScene, transition: transition)
        }
        
    }
}
