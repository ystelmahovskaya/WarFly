//
//  Enemy.swift
//  WarFly
//
//  Created by Yuliia Stelmakhovska on 2017-08-28.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import UIKit
import SpriteKit

class Enemy: SKSpriteNode {

    static var textureAtlas:SKTextureAtlas?
    var enemyTexture : SKTexture!
    
    init(enemyTexture: SKTexture){
    let texture = enemyTexture
        super.init(texture: texture, color: .clear, size: CGSize(width: 221, height: 204))
        self.xScale = 0.5
        self.yScale = -0.5
self.zPosition = 20
        self.name = "sprite"
        
     
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
//        if both object isdynamic = false colision doesnt happens
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskKategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = BitMaskKategory.none.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskKategory.player.rawValue | BitMaskKategory.shot.rawValue
    }
    
    
    func flySpiral(){
         let screen =  UIScreen.main.bounds
        let time:Double = 3
        let timeVertical:Double = 5
        
        //221*0.5=110 width of enemy, anchor in center 110/2 appr 50
        let moveLeft = SKAction.moveTo(x: 50, duration: time)
        //easeInEaseOut fast ftom start slow in finish of the action
        moveLeft.timingMode = .easeInEaseOut
        let moveRight = SKAction.moveTo(x: screen.width-50, duration: time)
        moveRight.timingMode = .easeInEaseOut
        let randomnumber = Int(arc4random_uniform(2))
        
        let asideMovementSequence = randomnumber == EnemyDirection.left.rawValue ? SKAction.sequence([moveLeft,moveRight]): SKAction.sequence([moveRight, moveLeft])
        
        let foreverAsideMovement = SKAction.repeatForever(asideMovementSequence)
        
        let forvardMovement = SKAction.moveTo(y: -105, duration: timeVertical)
        let groupMovement = SKAction.group([foreverAsideMovement,forvardMovement])
        self.run(groupMovement)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum EnemyDirection: Int{
case left = 0
    case right = 1
}
