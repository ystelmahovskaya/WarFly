//
//  Shot.swift
//  WarFly
//
//  Created by Yuliia Stelmakhovska on 2017-08-29.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import SpriteKit

class Shot: SKSpriteNode {
    let screensize = UIScreen.main.bounds
    fileprivate  let initialSize = CGSize(width: 187, height: 237)
    fileprivate let textureAtlas : SKTextureAtlas!
    fileprivate var textureNameBeginsWith = ""
    fileprivate var animationSpriteArray = [SKTexture]()
    
    init(textureAtlas: SKTextureAtlas){
        self.textureAtlas = textureAtlas
        let textureName = textureAtlas.textureNames.sorted()[0]
        let texture = textureAtlas.textureNamed(textureName)
        textureNameBeginsWith = String(textureName.characters.dropLast(6))
        super.init(texture: texture, color: .clear, size: initialSize)
        self.setScale(0.3)
        self.name = "shotSprite"
        self.zPosition = 30
        
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = BitMaskKategory.shot.rawValue
        self.physicsBody?.collisionBitMask = BitMaskKategory.enemy.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskKategory.enemy.rawValue 
    }
    
    func startMovement(){
        performRotation()
        let moveForvard = SKAction.moveTo(y: screensize.height+100, duration: 2)
        self.run(moveForvard)
        
        
    }
    fileprivate  func performRotation(){
        for i in 1...32{
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
