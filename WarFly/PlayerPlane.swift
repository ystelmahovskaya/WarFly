//
//  PlayerPlane.swift
//  WarFly
//
//  Created by Yuliia Stelmakhovska on 2017-08-22.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import SpriteKit
import CoreMotion

class PlayerPlane: SKSpriteNode {
    
    
    let motionManager = CMMotionManager() // Accelerometer usage motionManager controlls turns
    var xAcceleration: CGFloat = 0
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    
    var leftTextureArrayAnimation = [SKTexture]()
    var rightTextureArrayAnimation = [SKTexture]()
    var forwardTextureArrayAnimation = [SKTexture]()
    var moveDirection: TurnDirection = .none
    var stillTurning = false
    let animationSpriteStrides = [(13,1,-1), (13,26,1), (13,13,1)]
    
    
    static func populate (at point: CGPoint) -> PlayerPlane{
        
        let playerPlaneTexture = Assets.shared.playerPlaneAtlas.textureNamed("airplane_3ver2_13")//SKTexture(imageNamed: "airplane_3ver2_13")//texture can changes, image dont
        let playerPlane = PlayerPlane(texture: playerPlaneTexture)
        playerPlane.setScale(0.5)
        playerPlane.position = point
        playerPlane.zPosition = 40
        
//        physicsbody needed to manage colisions , Alphatreshhold makes the physiks shape of plane not square as picture of the plane but close to plane shape
     playerPlane.physicsBody = SKPhysicsBody(texture: playerPlaneTexture, alphaThreshold: 0.5, size: playerPlane.size)
        
        
//        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        //from website insyncapp.net SKPhhysicsBody Path Generator
//        let offsetX = playerPlane.frame.size.width *  playerPlane.anchorPoint.x
//        let offsetY = playerPlane.frame.size.height *  playerPlane.anchorPoint.y
//        
//        let path = CGMutablePath()
//        path.move(to: CGPoint(x:  7-offsetX, y:  75-offsetY))
//        path.addLine(to: CGPoint(x:  64-offsetX, y:  84-offsetY))
//        path.addLine(to: CGPoint(x:  70-offsetX, y:  98-offsetY))
//        path.addLine(to: CGPoint(x:  79-offsetX, y:  99-offsetY))
//        path.addLine(to: CGPoint(x:  84-offsetX, y:  85-offsetY))
//        path.addLine(to: CGPoint(x:  141-offsetX, y:  75-offsetY))
//           path.addLine(to: CGPoint(x:  141-offsetX, y:  66-offsetY))
//        path.addLine(to: CGPoint(x:  85-offsetX, y:  57-offsetY))
//        path.addLine(to: CGPoint(x:  8-offsetX, y:  64-offsetY))
//        path.closeSubpath()
//        
//        playerPlane.physicsBody = SKPhysicsBody(polygonFrom: path)


        

        
        
        
        
       // dont move when something other crushes with the plane
        playerPlane.physicsBody?.isDynamic = false
        playerPlane.physicsBody?.categoryBitMask = BitMaskKategory.player.rawValue
        playerPlane.physicsBody?.collisionBitMask = BitMaskKategory.enemy.rawValue | BitMaskKategory.powerUp.rawValue
        playerPlane.physicsBody?.contactTestBitMask = BitMaskKategory.enemy.rawValue | BitMaskKategory.powerUp.rawValue
        
        return playerPlane
    }
    
    func checkPosition(){
        
        self.position.x += xAcceleration * 50
        
        if self.position.x < -70{
            self.position.x = screenSize.width + 70
        } else if self.position.x > screenSize.width + 70 {
            self.position.x = -70
        }
    }
    
    func performFly() {
        planeAnimationFillArray()
      //  preloadTextureArrays()
        motionManager.accelerometerUpdateInterval = 0.2
        //OperationQueue threads
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { [unowned self] (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
                
            }
        }
        
        let planeWaitAction = SKAction.wait(forDuration: 1.0)
        let planeDirectionCheckAction = SKAction.run { [unowned self] in
            self.movementDirectionCheck()
        }
        
        let planeSequence = SKAction.sequence([planeWaitAction, planeDirectionCheckAction ])
        let planeSequenceForever = SKAction.repeatForever(planeSequence)
        self.run(planeSequenceForever)
    }
    
    
// func preloadTextureArrays(){
//        for i in 0...2 {
//         print(i)//first
//            self.preloadArray(_stride: self.animationSpriteStrides[i], callback: { [unowned self] array in
//                    print(i)//second
//                switch i {
//                   
//                case 0: self.leftTextureArrayAnimation = array
//                case 1: self.rightTextureArrayAnimation = array
//                case 2: self.forwardTextureArrayAnimation = array
//                default:break
//                }
//            })
//        }
//    }
    

    
    fileprivate func preloadArray(_stride: (Int,Int,Int), callback: @escaping(_ array: [SKTexture])-> ()){
        var array = [SKTexture]()
        for i in stride(from: _stride.0, to: _stride.1, by: _stride.2){
            let number = String(format: "%02d", i)
            let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
            array.append(texture)
        }
        SKTexture.preload(array){
            callback(array)
        }
    }
    
    
        //fill    array for player animation
        fileprivate func planeAnimationFillArray(){
            SKTextureAtlas.preloadTextureAtlases([SKTextureAtlas(named: "PlayerPlane")]) {
                self.leftTextureArrayAnimation = {
                    var array = [SKTexture]()
                    for i in stride(from: 13, through: 1, by: -1){
                        let number = String(format: "%02d", i)
                        let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
                        array.append(texture)
                    }
                    SKTexture.preload(array, withCompletionHandler: {
                        print("done")
                    })
                    return array
                }()
    
                self.rightTextureArrayAnimation = {
                    var array = [SKTexture]()
                    for i in stride(from: 13, through: 26, by: 1){
                        let number = String(format: "%02d", i)
                        let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
                        array.append(texture)
                    }
                    SKTexture.preload(array, withCompletionHandler: {
                        print("done")
                    })
                    return array
                }()
    
                self.forwardTextureArrayAnimation = {
                    var array = [SKTexture]()
    
                        let texture = SKTexture(imageNamed: "airplane_3ver2_13")
                        array.append(texture)
    
                    SKTexture.preload(array, withCompletionHandler: {
                        print("done")
                    })
                    return array
                }()
    
    
            }
    
        }
    
    fileprivate func movementDirectionCheck(){
        
        if xAcceleration > 0.02, moveDirection != .right , stillTurning==false { //turn right
            stillTurning = true
            moveDirection = .right
            turnPlane(direction: .right)
        } else if xAcceleration < -0.02, moveDirection != .left , stillTurning==false {
            stillTurning = true
            moveDirection = .left
            turnPlane(direction: .left)
        } else if stillTurning == false{
            turnPlane(direction: .none)
        }
    }
    
    
    fileprivate func turnPlane(direction: TurnDirection){
        var array = [SKTexture]()
        if direction == .right{
            array = rightTextureArrayAnimation
        } else if direction == .left{
            array = leftTextureArrayAnimation
        } else {
            array = forwardTextureArrayAnimation
        }
        
        let forwardAction = SKAction.animate(with: array, timePerFrame: 0.05, resize: true, restore: false)
        let backwardAction = SKAction.animate(with: array.reversed(), timePerFrame: 0.05, resize: true, restore: false)
        
        let sequenceAction = SKAction.sequence([forwardAction,backwardAction])
        self.run(sequenceAction){[unowned self] in
            self.stillTurning = false
        }
    }
    
    func greenPowerUp(){
        let colorAction = SKAction.colorize(with: .green, colorBlendFactor: 1.0, duration: 0.2)
        let unColorAction = SKAction.colorize(with: .green, colorBlendFactor: 0.0, duration: 0.2)
        let sequenceAction = SKAction.sequence([colorAction, unColorAction])
        let repeatAcrion = SKAction.repeat(sequenceAction, count: 5)
        self.run(repeatAcrion)
    }
    func bluePowerUp(){
        let colorAction = SKAction.colorize(with: .blue, colorBlendFactor: 1.0, duration: 0.2)
        let unColorAction = SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.2)
        let sequenceAction = SKAction.sequence([colorAction, unColorAction])
        let repeatAcrion = SKAction.repeat(sequenceAction, count: 5)
        self.run(repeatAcrion)
    }
}
enum TurnDirection {
    case left
    case right
    case none
    
}































