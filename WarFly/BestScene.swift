//
//  BestScene.swift
//  WarFly
//
//  Created by Yuliia Stelmakhovska on 2017-09-05.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import SpriteKit

class BestScene: ParentScene {
    
    var places : [Int]!
    
    override func didMove(to view: SKView) {
        gameSettings.loadScores()
        places = gameSettings.highScore
       
        
        //        let header = ButtonNode(titled: "pause", backgroundName: "header_background")
        //        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY+150)
        //        self.addChild(header)
        
        
        setHeader(withName: "Best", andBackground:"header_background")
        
        let titles = ["back"]
        
        for  title in titles {
            
            let button = ButtonNode(titled: title, backgroundName: "button_background")
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 200)
            button.name = title
            button.label.name = title
            addChild(button)
        }

        
 
        
        for (index, value) in places.enumerated() {
        
            let l = SKLabelNode(text: value.description)
            l.fontColor = UIColor(red: 219/255, green: 226/255, blue: 215/255, alpha: 1.0)
            l.fontName = "AmericanTypewriter-Bold"
            l.fontSize = 30
            l.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(index*60))
        addChild(l)
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        first touch inside the scene
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        if node.name == "back"{
            
            let transition  = SKTransition.crossFade(withDuration: 1.0)
            guard let backScene = backScene else {return}
            backScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(backScene, transition: transition)
        }
        
    }
}
