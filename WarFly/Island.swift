//
//  Island.swift
//  WarFly
//
//  Created by Yuliia Stelmakhovska on 2017-08-21.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import SpriteKit
import GameplayKit

final class Island: SKSpriteNode, GameBackgroundSpriable {
    
    
    static func populate(at point: CGPoint?)-> Island {
        
        let  islandImageName = configureName()
        let island = Island (imageNamed:islandImageName)
        island.setScale(randomScaleFactor)
        island.position = point ?? randomPoint()
        //        one step upper than parent (background)
        island.zPosition = 1
        island.name = "sprite"
        //when dissapear needed
        island.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        island.run(rotateForRandomeAndle())
        island.run(move(from: island.position))
        return island
        
    }
    
    fileprivate   static func configureName()-> String{
        let destribution = GKRandomDistribution(lowestValue: 1, highestValue: 4)
        let randomNumber = destribution.nextInt()
        let imageName = "is"+"\(randomNumber)"
        return imageName
    }
    
    fileprivate   static var randomScaleFactor: CGFloat {
        let destribution = GKRandomDistribution(lowestValue: 1, highestValue: 10)
        let randomNumber = CGFloat(destribution.nextInt())/10
        return randomNumber
    }
    
    fileprivate   static func rotateForRandomeAndle() -> SKAction{
        let destribution = GKRandomDistribution(lowestValue: 0, highestValue: 360)
        let randomNumber = CGFloat(destribution.nextInt())
        
        //convert to radians
        return SKAction.rotate(toAngle: randomNumber * CGFloat(Double.pi / 180), duration: 0)
    }
    
    
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
    let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed : CGFloat = 100.0
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}




