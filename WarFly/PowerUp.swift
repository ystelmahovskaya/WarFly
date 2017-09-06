//
//  PowerUp.swift
//  WarFly
//
//  Created by Yuliia Stelmakhovska on 2017-08-25.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import SpriteKit



class PowerUp: SKSpriteNode {
    
  fileprivate  let initialSize = CGSize(width: 52, height: 52)
   fileprivate let textureAtlas : SKTextureAtlas!
   fileprivate var textureNameBeginsWith = ""
   fileprivate var animationSpriteArray = [SKTexture]()
    
    init(textureAtlas: SKTextureAtlas){
        self.textureAtlas = textureAtlas
        let textureName = textureAtlas.textureNames.sorted()[0]
        let texture = textureAtlas.textureNamed(textureName)
        textureNameBeginsWith = String(textureName.characters.dropLast(6))
        super.init(texture: texture, color: .clear, size: initialSize)
        self.setScale(0.7)
        self.name = "sprite"
        self.zPosition = 20
        
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskKategory.powerUp.rawValue
        self.physicsBody?.collisionBitMask = BitMaskKategory.player.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskKategory.player.rawValue
    }
    
    func startMovement(){
    performRotation()
        let moveForvard = SKAction.moveTo(y: -100, duration: 5)
        self.run(moveForvard)
        
        
    }
  fileprivate  func performRotation(){
        for i in 1...15{
            let number = String(format: "%02d", i)
            animationSpriteArray.append(SKTexture(imageNamed: textureNameBeginsWith+number.description))
            
        }
        SKTexture.preload(animationSpriteArray){
            //restore: false dont go back to start size
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.05, resize: true, restore: false)
            
            let rotationForever = SKAction.repeatForever(rotation)
            self.run(rotationForever)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
