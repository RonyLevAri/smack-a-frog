//
//  Game.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 09/07/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import Foundation

class Game: NSObject {
    
    private let gameConfig: GameConfig
    
    private var playerState = PlayerGameState()
    
    private weak var gameTimer: Timer?
    
    private var _board: GameBoard
    
    var board: GameBoard {
        return _board
    }
    
    init(gameConfig: GameConfig, board: GameBoard) {
        self.gameConfig = gameConfig
        self._board = board
    }
    
    func startGame() {
        gameTimer = Timer.scheduledTimer(
            timeInterval: gameConfig.gameIntervalInSeconds,
            target: self,
            selector: #selector(Game.stopGame),
            userInfo: nil,
            repeats: false)
    }
    
    func stopGame() {
        gameTimer?.invalidate()
    }
    
    private func balancePoints(_ points: Int) {
        playerState.points = points
    }
    
    var gamePoints: Int {
        get {
            return playerState.points
        }
    }
    
    private struct PlayerGameState {
        var misses = 0
        var points = 0
        var useOfShake = 0
    }
    
    private enum SmackStatus {
        case Miss
        case Hit
        case Pannelty
    }
    
}

struct PositionOnBoard {
    let row: Int
    let column: Int
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
}


