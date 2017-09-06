//
//  GameBackgroundSpritable+Extension.swift
//  WarFly
//
//  Created by Yuliia Stelmakhovska on 2017-08-23.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameBackgroundSpriable{
    static func populate(at point: CGPoint?) -> Self // returns protocol type or class type
    static func randomPoint()-> CGPoint
}

//generation of points out of screen bounds
extension GameBackgroundSpriable {
    static func randomPoint()-> CGPoint {
        let screen = UIScreen.main.bounds
        
        let distribution = GKRandomDistribution(lowestValue: Int(screen.size.height)+400 , highestValue: Int(screen.size.height)+500)
        let y = CGFloat(distribution.nextInt())
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        return CGPoint(x: x , y: y)
        
    }
}
