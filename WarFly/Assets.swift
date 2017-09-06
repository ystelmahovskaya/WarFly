//
//  Assets.swift
//  WarFly
//
//  Created by Yuliia Stelmakhovska on 2017-08-29.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import SpriteKit

class Assets {
static let shared = Assets()
    var isLoaded = false
    let yellowShotAtlas = SKTextureAtlas(named: "YellowAmmo")
    let enemy_1Atlas = SKTextureAtlas(named: "Enemy_1")
    let enemy_2Atlas = SKTextureAtlas(named: "Enemy_2")
    let greenPowerUpAtlas = SKTextureAtlas(named: "GreenPowerUp")
    let bluePowerUpAtlas = SKTextureAtlas(named: "BluePowerUp")
    let playerPlaneAtlas = SKTextureAtlas(named: "PlayerPlane")
    
 func preloadAssets(){
   
    yellowShotAtlas.preload { }
    
    enemy_1Atlas.preload { 
       
    }
    enemy_2Atlas.preload { 
        
    }
    greenPowerUpAtlas.preload { 
         }
    bluePowerUpAtlas.preload { 
         }
    playerPlaneAtlas.preload { 
      
    }
}
}
