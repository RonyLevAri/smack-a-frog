//
//  FrogHole.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 17/07/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import Foundation

struct FrogHole {
    
    private var _state = FrogHoleState.NonHittableNoFrog
    
    var state: FrogHoleState {
        get {
            return _state
        }
    }
    
    mutating func changeStateRandomly() {
        _state = FrogHoleState.randomState()
    }
    
    mutating func resetToNonHittable() {
        _state = FrogHoleState.NonHittableNoFrog
    }
}

enum FrogHoleState {
    case HittableAngryForg
    case HittableContagiousFrog
    case NonHittableNoFrog
    
    static func randomState() -> FrogHoleState {
        let allValues = [HittableAngryForg, HittableContagiousFrog, NonHittableNoFrog]
        let index = Int(arc4random_uniform(UInt32(allValues.count)))
        return allValues[index]
    }
}
