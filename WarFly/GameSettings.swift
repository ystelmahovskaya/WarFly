//
//  GameSettings.swift
//  WarFly
//
//  Created by Yuliia Stelmakhovska on 2017-09-06.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import UIKit

class GameSettings: NSObject {
    
    let ud = UserDefaults.standard
    
    var isMusic = true
    var isSound = true
    
    let musicKey = "music"
    let soundKey = "sound"
    
    var highScore: [Int] = []
    var highScoreKey = "highscore"
    var currentscore = 0
    
    
    override init() {
        super.init()
        loadGameSettings()
        loadScores()
    }
    
    func saveGameSettings(){
        ud.set(isMusic, forKey: musicKey)
        ud.set(isSound, forKey: soundKey)
        
    }
    func loadGameSettings(){
        guard ud.value(forKey: soundKey) != nil && ud.value(forKey: musicKey) != nil  else { return }
        isMusic = ud.bool(forKey: musicKey)
        isSound = ud.bool(forKey: soundKey)
        
    }
    
    func saveScores(){
        highScore.append(currentscore)
        highScore = Array(highScore.sorted { $0 > $1 }.prefix(3))
        ud.set(highScore, forKey: highScoreKey)
        ud.synchronize()
        
    }
    
    func loadScores(){
        guard ud.value(forKey: highScoreKey) != nil else { return }
        highScore = ud.array(forKey: highScoreKey) as! [Int]
    
    }
    
}
