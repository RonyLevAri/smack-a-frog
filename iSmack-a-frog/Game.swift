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
    func updateLivesLeft(_ lives: Int)
    func updateAllCells()
    func animateItemAt(_ row: Int, _ column: Int, for frogHoleState: FrogHoleState)
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
        // print("game is counting till 3 before starting the game")
        _gameTimer = Timer.scheduledTimer(
            timeInterval: _gameConfig.delayBeforeStartingTheGame,
            target: self,
            selector: #selector(Game.startGameCountdowon),
            userInfo: nil,
            repeats: false)
    }
    
    func startGameCountdowon() {
        // print("game is starting the game")
        _boardTimersController.start()
        _gameTimer = Timer.scheduledTimer(
            timeInterval: _gameConfig.gameIntervalInSeconds,
            target: self,
            selector: #selector(Game.stopGame),
            userInfo: nil,
            repeats: false)
    }
    
    func stopGame() {
        // print("game is stopping game")
        _gameTimer?.invalidate()
        _boardTimersController.stop()
        _board.resetAllCells()
        delegate?.updateAllCells()
    }
    
    func cellTappedAt(row: Int, column: Int) {
        
        // print("game recieved tapping action on cell \(row) \(column)")
        
        let state = _board.getCellStateAt(row, column)
            
        switch state {
        case .HittableAngryForg:
            addpoints()
            animateItemAt(row, column, for: state)
            resetCellAndTimerAt(row, column)
        case .HittableContagiousFrog:
            takeLife()
            animateItemAt(row, column, for: state)
            resetCellAndTimerAt(row, column)
        case .NonHittableNoFrog:
            break
        }
    }
    
    private func animateItemAt(_ row: Int, _ column: Int, for frogHoleState: FrogHoleState) {
        delegate?.animateItemAt(row, column, for: frogHoleState)
    }
    
    private func resetCellAndTimerAt(_ row: Int, _ column: Int) {
        //print("game reset timer  \(row) \(column) after tapping")
        _boardTimersController.resetTimerAt(row, column)
        _board.resetCellAt(row, column)
        delegate?.updateCelltAt(row, column)
    }
    
    
    private func addpoints() {
        // print("game adding points for tapping")
        _playerState.points += 1
        delegate?.updatePoints(_playerState.points)
        if _playerState.points >= 30 {
            stopGame()
        }
    }
    
    fileprivate func takeLife() {
        // print("game taking life for tapping")
        _playerState.lives -= 1
        delegate?.updateLivesLeft(_playerState.lives)
        if _playerState.lives == 0 {
            // print("game stopping game because life ended")
            stopGame()
        }
    }
    
    var gamePoints: Int {
        get {
            return _playerState.points
        }
    }
    
    private struct PlayerGameState {
        var lives = 3
        var points = 0
        var shakes = 3
    }

}

extension Game: BoardTimerControllerDelegate {
    func cellTimerRunningAt(_ row: Int, _ column: Int) {
        // print("game recieved a message that \(row) \(column) is running")
        _board.activateCellAt(row, column)
        delegate?.updateCelltAt(row, column)
    }
    
    func  cellTimerIdleAt(_ row: Int, _ column: Int) {
        // print("game recieved a message that \(row) \(column) is idle")
        _board.resetCellAt(row, column)
        delegate?.updateCelltAt(row, column)
    }
}



