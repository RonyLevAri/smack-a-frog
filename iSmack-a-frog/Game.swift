//
//  Game.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 09/07/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import Foundation

struct Game {
    
    private let gameConfig: GameConfig
    private var playerState = PlayerState()
    private weak var timer: Timer?
    private var launchTimer = false {
        didSet {
            startGameTimer()
        }
    }
    
    private lazy var frogHoles:[FrogHole] = {
        let size = self.gameConfig.boardSize.rows * self.gameConfig.boardSize.columns
        return [FrogHole](repeating: FrogHole(), count: size)
    }()
    
    init(gameConfig: GameConfig) {
        self.gameConfig = gameConfig
    }
    
    func start() {
        
    }
    
    mutating private func startGameTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) {_ in
            // updateView()
            print("something")
        }
    }
    
    private func initiateGameBoard() {}
    
    
    mutating private func balancePoints(_ points: Int) {
        playerState.points = points
    }
    
    var gamePoints: Int {
        get {
            return playerState.points
        }
    }
    
    private struct PlayerState {
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

