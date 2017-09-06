//
//  GameScene.swift
//  WarFly
//
//  Created by Yuliia Stelmakhovska on 2017-08-21.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: ParentScene {
    
    var backgroundMusik: SKAudioNode!
    
    fileprivate  var player: PlayerPlane!
    fileprivate  let hud = HUD()
    fileprivate let screenSize = UIScreen.main.bounds.size
    fileprivate var lives = 3 {
        didSet{
            switch lives {
            case 3:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = false
            case 2:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = true
            case 1:
                hud.life1.isHidden = false
                hud.life2.isHidden = true
                hud.life3.isHidden = true
            default:
                break
            }
        }
    }
    
    
    
    
    
    
    override func didMove(to view: SKView) {
        gameSettings.loadGameSettings()
        if gameSettings.isMusic && backgroundMusik == nil{
            //        to play music need to check if file exists
            if let musicURL = Bundle.main.url(forResource: "backgroundMusic", withExtension: "m4a"){
                backgroundMusik = SKAudioNode(url: musicURL)
                addChild(backgroundMusik)
            }
        }
        self.scene?.isPaused = false
        //        checking if scene was created and saved to manager
        guard sceneManager.gameScene == nil else { return }
        
        //saving current scene to scene manager to call it from pause
        sceneManager.gameScene = self
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        
        configureStartScene()
        spawnClouds()
        spawnIslands()
        //        let deadline = DispatchTime.now() + .nanoseconds(1)
        //        //to prevent white square appearance instead of the plane
        //        DispatchQueue.main.asyncAfter(deadline: deadline){[unowned self] in
        self.player.performFly()
        //        }
        spawnPowerUp()
        spawnEnemies()
        //spawnEnemy(count: 5)
        createHUD()
        
        
    }
    
    fileprivate func createHUD(){
        addChild(hud)
        hud.configureUI(screenSize: screenSize)
    }
    
    
    
    fileprivate func spawnEnemies(){
        let waitAction = SKAction.wait(forDuration: 3.0)
        let spawnSpiralAction = SKAction.run { [unowned self] in
            self.spawnSpiralOfEnemies()
        }
        self.run(SKAction.repeatForever(SKAction.sequence([waitAction,spawnSpiralAction])))
        
    }
    
    
    fileprivate func spawnSpiralOfEnemies(){
        let enemyTextureAtlas1 = Assets.shared.enemy_1Atlas
        let enemyTextureAtlas2 = Assets.shared.enemy_2Atlas//SKTextureAtlas(named: "Enemy_2")
        SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas1,enemyTextureAtlas2]) { [unowned self] in
            
            let randomNumber = Int(arc4random_uniform(2))
            let arrayOfAtlases = [enemyTextureAtlas1, enemyTextureAtlas2]
            let textureAtlas = arrayOfAtlases[randomNumber]
            
            let waitAction = SKAction.wait(forDuration: 1.0)
            let spawnEnemy = SKAction.run({
                let textureNames = textureAtlas.textureNames.sorted()
                let texture = textureAtlas.textureNamed(textureNames[12])
                let enemy = Enemy(enemyTexture: texture)
                enemy.position = CGPoint(x: self.size.width/2, y: self.size.height+110)
                self.addChild(enemy)
                enemy.flySpiral()
            })
            let spawnAction = SKAction.sequence([waitAction,spawnEnemy])
            let repeatAction = SKAction.repeat(spawnAction, count: 3)
            self.run(repeatAction)
        }
    }
    
    
    
    fileprivate func spawnPowerUp(){
        let spawnAction = SKAction.run { [unowned self] in
            let randomNumber = Int(arc4random_uniform(2))
            let powerUp = randomNumber == 1 ? BluePowerUp() : GreenPowerUp()
            let randomPositionX = arc4random_uniform(UInt32(self.size.width-30))
            powerUp.position = CGPoint(x: CGFloat(randomPositionX), y: self.size.height+100)
            powerUp.startMovement()
            self.addChild(powerUp)
        }
        let randomTimeSpawn = Double(arc4random_uniform(11) + 10)
        
        let waitAction = SKAction.wait(forDuration: randomTimeSpawn)
        self.run(SKAction.repeatForever( SKAction.sequence([spawnAction,waitAction])))
        
    }
    
    
    
    //creates clouds infinit
    fileprivate func spawnClouds(){
        
        //        every sec creates a cloud
        let spawnCloudWait = SKAction.wait(forDuration: 1)
        let spawnCloudAction = SKAction.run {
            let cloud = Cloud.populate(at: nil)
            self.addChild(cloud)
        }
        
        let spawnCloudSequence = SKAction.sequence([spawnCloudWait,spawnCloudAction])
        let spawnCloudForever = SKAction.repeatForever(spawnCloudSequence)
        run(spawnCloudForever)
        
    }
    
    
    
    
    fileprivate func spawnIslands(){
        let spawnIslandWait = SKAction.wait(forDuration: 1)
        let spawnIslandAction = SKAction.run {
            let island = Island.populate(at: nil)
            self.addChild(island)
            
        }
        
        let spawnIslandSequence = SKAction.sequence([spawnIslandWait,spawnIslandAction])
        let spawnIslandForever = SKAction.repeatForever(spawnIslandSequence)
        run(spawnIslandForever)
        
    }
    
    
    
    fileprivate func configureStartScene(){
        let screenCenterPoint =  CGPoint(x: self.size.width/2 , y: self.size.height/2 )
        
        let background = Background.populateBackground(at: screenCenterPoint)
        background.size = self.size
        self.addChild(background)
        background.zPosition = 0
        
        let screen =  UIScreen.main.bounds
        
        //        let x : CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width) ))
        //        let y : CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.height) ))
        
        let island1 = Island.populate(at: CGPoint(x: 100, y: 200))
        self.addChild(island1)
        
        
        let island2 = Island.populate(at: CGPoint(x: self.size.width-100, y: self.size.height-200))
        self.addChild(island2)
        
        //        let cloud  = Cloud.populateSprite(at: CGPoint(x: x, y: y))
        //        self.addChild(cloud)
        
        player = PlayerPlane.populate(at: CGPoint(x: screen.size.width/2, y: 100))
        self.addChild(player)
        
        
    }
    
    
    override func didSimulatePhysics() {
        
        player.checkPosition()
        //<#UnsafeMutablePointer<ObjCBool>#> flag true or false (kursor)
        //cleening nodes out of scene
        enumerateChildNodes(withName: "sprite") { (node, stop) in
            if node.position.y <= -100 {
                node.removeFromParent()
                //                if node .isKind(of: PowerUp.self){
                //                print("pa removed")
                //                }
            }
        }
        enumerateChildNodes(withName: "shotSprite") { (node, stop) in
            if node.position.y >= self.size.height+20 {
                node.removeFromParent()
            }
        }
        enumerateChildNodes(withName: "greenPowerUp") { (node, stop) in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
        enumerateChildNodes(withName: "bluePowerUp") { (node, stop) in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
    }
    
    fileprivate func playerFire(){
        let shot = YellowShot()
        shot.position = self.player.position
        shot.startMovement()
        self.addChild(shot)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        first touch inside the scene
        
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "pause"{
            let transition  = SKTransition.doorway(withDuration: 1.0)
            let pauseScene = PauseScene(size: self.size)
            pauseScene.scaleMode = .aspectFill
            self.scene?.isPaused = true
            sceneManager.gameScene = self
            self.scene!.view?.presentScene(pauseScene, transition: transition)
        }else{
            playerFire()
        }
        
    }
    
}
extension GameScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        
        let explosion = SKEmitterNode(fileNamed: "EnemyExplosion")
        let contactPoint = contact.contactPoint
        explosion?.position = contactPoint
        explosion?.zPosition = 25
        let waitForExplosionAction = SKAction.wait(forDuration: 2)
        
        let contactCategory: BitMaskKategory = [contact.bodyA.category, contact.bodyB.category]
        
        switch contactCategory {
        case [.enemy,.player]:print("player vs enemy")
        if contact.bodyA.node?.name=="sprite"{
            //            check if colision had happened
            if  contact.bodyA.node?.parent != nil {
                contact.bodyA.node?.removeFromParent()
                lives-=1
            }
        } else {
            if  contact.bodyB.node?.parent != nil {
                contact.bodyB.node?.removeFromParent()
                lives-=1
            }
        }
        addChild(explosion!)
        self.run(waitForExplosionAction, completion: {
            explosion?.removeFromParent()
        })
        
        
        if lives == 0 {
            gameSettings.currentscore = hud.score
            gameSettings.saveScores()
            let gameOverScene = GameOverScene(size: self.size)
            gameOverScene.scaleMode = .aspectFill
            
            let transition = SKTransition.doorsCloseVertical(withDuration: 1.0)
            self.scene!.view?.presentScene(gameOverScene, transition: transition)
            
            }
            
        case [.powerUp,.player]:print("player vs powerUp")
        
        
        
        if  contact.bodyA.node?.parent != nil && contact.bodyB.node?.parent != nil  {
            if contact.bodyA.node?.name == "bluePowerUp" {
                contact.bodyA.node?.removeFromParent()
                lives=3
                player.bluePowerUp()
            } else if contact.bodyB.node?.name == "bluePowerUp" {
                contact.bodyB.node?.removeFromParent()
                lives=3
                player.bluePowerUp()
            }
            if contact.bodyA.node?.name == "greenPowerUp" {
                contact.bodyA.node?.removeFromParent()
                lives=3
                player.greenPowerUp()
            } else if contact.bodyB.node?.name == "greenPowerUp" {
                contact.bodyB.node?.removeFromParent()
                lives=3
                player.greenPowerUp()
            }
            
            }
            
            
            
            
        case [.enemy,.shot]:print("shot vs enemy")
        if  contact.bodyA.node?.parent != nil && contact.bodyB.node?.parent != nil {
            if gameSettings.isSound == true{
            self.run(SKAction.playSoundFileNamed("hitSound", waitForCompletion: false))
            }
            hud.score+=5
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            addChild(explosion!)
            self.run(waitForExplosionAction, completion: {
                explosion?.removeFromParent()
            })
            }
            
        default:
            preconditionFailure("unable to detect collision category")
        }
        
        //        let bodyA = contact.bodyA.categoryBitMask
        //        let bodyB = contact.bodyB.categoryBitMask
        //
        //        let player = BitMaskKategory.player
        //         let enemy = BitMaskKategory.enemy
        //         let powerUp = BitMaskKategory.powerUp
        //        let shot = BitMaskKategory.shot
        //
        //        if bodyA == player && bodyB == enemy ||  bodyB == player && bodyA == enemy{
        //        print("player vs enemy")
        //        } else if bodyA == player && bodyB == powerUp ||  bodyB == player && bodyA == powerUp{
        //         print("player vs powerUp")
        //        }else if bodyA == enemy && bodyB == shot ||  bodyB == enemy && bodyA == shot{
        //             print("shot vs enemy")
        //        }
        
    }
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}

