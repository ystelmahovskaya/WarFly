//
//  BitMaskKategory.swift
//  WarFly
//
//  Created by Yuliia Stelmakhovska on 2017-08-30.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import SpriteKit

//enum BitMaskKategory {
//    case player
//    case enemy
//    case powerUp
//    case shot
//}
//UInt32 used to create bit masks

extension SKPhysicsBody{
    var category: BitMaskKategory {
        get{
        return BitMaskKategory(rawValue: self.categoryBitMask)
        }
        set (newValue){
        self.categoryBitMask = newValue.rawValue
        }
    
    
    
    }
    
}
struct BitMaskKategory: OptionSet {
    let  rawValue: UInt32
    
    init(rawValue: UInt32){
    self.rawValue = rawValue
    }
    static let none = BitMaskKategory(rawValue: 0 << 0)
    static let player = BitMaskKategory(rawValue: 1 << 0)
     static let enemy = BitMaskKategory(rawValue: 1 << 1)
     static let powerUp = BitMaskKategory(rawValue: 1 << 2)
     static let shot = BitMaskKategory(rawValue: 1 << 3)
    static let all = BitMaskKategory(rawValue: UInt32.max) //111111111111111
    
    
    
    
//    static let player: UInt32 = 0x1 << 0  //00000....001    1
//    static let enemy: UInt32 = 0x1 << 1   //000000....010    2
//    static let powerUp: UInt32 = 0x1 << 2 //000000....100  4
//static let shot: UInt32 = 0x1 << 3        //000000...1000  8
//                                          //000000...1111  all
    
}
