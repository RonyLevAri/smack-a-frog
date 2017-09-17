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
    let minTimeFrogAppearsOnScreen = 2.0
    let maxTimeFrogAppearsOnScreen = 4.0
    let delayPanelty = 3.0
    var timeTargetAppersOnScreen: Range<Double> {
        get {
            return minTimeFrogAppearsOnScreen..<maxTimeFrogAppearsOnScreen
        }
    }
    let delayBeforeStartingTheGame = 2.0
    let boardSize: BoardSize
    lazy var latencyBetweenTimers: Range<Double> = {
        return self.calcLatencyBasedOnDifficulty()
    }()
    
    init(difficulty: GameDifficulty, boardSize: BoardSize) {
        self.difficulty = difficulty
        self.boardSize = boardSize
    }
    
    var frogHoleManagerPace: Double {
        get {
            switch difficulty {
            case .Easy:
                return 3.0
            case .Normal:
                return 2.5
            case .Hard:
                return 1.5
            }
        }
    }
    
    private func calcLatencyBasedOnDifficulty() -> Range<Double> {
        
        var range: Range<Double>
        
        switch difficulty {
        case .Easy:
            range = 0.0..<20.0
        case .Normal:
            range = 0.0..<15.0
        case .Hard:
            range = 0.0..<3.0
        }
        
        return range
    }
    
}


