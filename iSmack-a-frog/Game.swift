//
//  Game.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 09/07/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import Foundation

struct Game {
    
    private let gameConfiguration: GameConfig
    
    private var playerState = PlayerState()
    private weak var timer: Timer?
    private var launchTimer = false {
        didSet {
            startTimer()
        }
    }
    
    mutating private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) {_ in
            // updateView()
            print("something")
        }
    }
    
    mutating private func balancePoints(_ points: Int) {
        playerState.points = points
    }
    
    var gamePoints: Int {
        get {
            return playerState.points
        }
    }
    
    init(gameConfig: GameConfig) {
        gameConfiguration = gameConfig
        launchTimer = true
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
    
    private struct GameBoard {
        private let rows: Int
        private let columns: Int
    }
}


struct BoardTeal {
    
    enum TealState {
        case WithForg
        case WithoutFrog
    }
}

enum Difficulty: String {
    case Easy
    case Normal
    case Hard
}
