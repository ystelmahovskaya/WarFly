//
//  Background.swift
//  WarFly
//
//  Created by Yuliia Stelmakhovska on 2017-08-21.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import SpriteKit

class Background: SKSpriteNode {
    
//   can not overrides uses with this class, can not call usual function
    static func populateBackground(at point: CGPoint)-> Background {
    let background = Background(imageNamed: "background")
        background.position = point
        
        
        return background
    }
}
