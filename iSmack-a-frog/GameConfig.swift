//
//  GameConfig.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 13/07/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import Foundation

struct GameConfig {

    let difficulty: GameDifficulty
    let maxMisses = 3
    let maxShake = 3
    let gameIntervalInSeconds = 60.0
    let minTimeFrogAppearsOnScreen = 1.5
    let maxTimeFrogAppearsOnScreen = 4.0
    let delayBeforeStartingTheGame = 3.0
    let boardSize: BoardSize
    
    init(difficulty: GameDifficulty, boardSize: BoardSize) {
        self.difficulty = difficulty
        self.boardSize = boardSize
    }
    
    var frogHoleManagerPace: Double {
        get {
            switch difficulty {
            case .Easy:
                return 4.0
            case .Normal:
                return 3.0
            case .Hard:
                return 2.0
            }
        }
    }
    
}


