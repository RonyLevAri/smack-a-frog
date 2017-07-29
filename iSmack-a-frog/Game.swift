//
//  Game.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 09/07/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import Foundation

protocol GameDelegate: class {
    func updatePoints(_ points: Int)
    func updateCelltAt(_ row: Int, _ column: Int)
}

class Game: NSObject {
    
    private let _gameConfig: GameConfig
    
    private var _playerState = PlayerGameState()
    
    private weak var _gameTimer: Timer?
    
    weak var delegate: GameDelegate?
    
    fileprivate var _board: GameBoard
    
    private var _boardTimersController: BoardTimerController
    
    var board: GameBoard {
        return _board
    }
    
    init(gameConfig: GameConfig, board: GameBoard, timerController: BoardTimerController) {
        self._gameConfig = gameConfig
        self._board = board
        self._boardTimersController = timerController
    }
    
    func startGame() {
        print("counting till 3 before starting the game")
        _gameTimer = Timer.scheduledTimer(
            timeInterval: _gameConfig.delayBeforeStartingTheGame,
            target: self,
            selector: #selector(Game.startGameCountdowon),
            userInfo: nil,
            repeats: false)
    }
    
    func startGameCountdowon() {
        print("starting the game")
        _boardTimersController.start()
        _gameTimer = Timer.scheduledTimer(
            timeInterval: _gameConfig.gameIntervalInSeconds,
            target: self,
            selector: #selector(Game.stopGame),
            userInfo: nil,
            repeats: false)
    }
    
    func stopGame() {
        print("finishing game")
        _boardTimersController.stop()
    }
    
    func cellTappedAt(row: Int, column: Int) {
        
        let isTimerRunning = _boardTimersController.isTimerRunnindAt(row: row, column: column)
        print("isTimerRunning = \(isTimerRunning)")
        
        if isTimerRunning {
            let state = _board.getCellStateAt(row, column)
            
            switch state {
            case .HittableAngryForg:
                addpoints()
            case .HittableContagiousFrog:
                takeLife()
            case .NonHittableNoFrog:
                break
            }
            
            _board.resetCellAt(row, column)
            _boardTimersController.resetTimerAt(row: row, column: column)
            delegate?.updateCelltAt(row, column)
        }
    }
    
    private func addpoints() {
        _playerState.points += 1
        delegate?.updatePoints(_playerState.points)
    }
    
    private func takeLife() {
        print("falied to tap")
    }
    
    var gamePoints: Int {
        get {
            return _playerState.points
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

extension Game: BoardTimerControllerDelegate {
    func activationTimerGotSetAt(_ row: Int, _ column: Int) {
        _board.activateCellAt(row, column)
        delegate?.updateCelltAt(row, column)
    }
    
    func  latencyTimerGotSetAt(_ row: Int, _ column: Int) {
        _board.resetCellAt(row, column)
        delegate?.updateCelltAt(row, column)
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


