//
//  Game.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 09/07/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import Foundation

struct Game {
    
    private var accumulator: Int = 0
    
    mutating func balancePoints(_ points: Int) {
        accumulator = points
    }
    
    var gamePoints: Int {
        get {
            return accumulator
        }
    }
    
    
}

struct GameBoard {

}

struct BoardTeal {

}

struct Player {
    
}

enum Difficulty: String {
    case Easy
    case Normal
    case Hard
}
