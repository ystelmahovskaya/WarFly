//
//  YellowShot.swift
//  WarFly
//
//  Created by Yuliia Stelmakhovska on 2017-08-29.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import SpriteKit

class YellowShot: Shot {
    init(){
        let textureAtlas = Assets.shared.yellowShotAtlas//SKTextureAtlas(named: "YellowAmmo")

        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
