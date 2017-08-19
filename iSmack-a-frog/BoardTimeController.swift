//
//  BoardTimeController.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 29/07/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import Foundation

protocol BoardTimerControllerDelegate: class {
    func cellTimerRunningAt(_ row: Int, _ column: Int)
    func cellTimerIdleAt(_ row: Int, _ column: Int)
}

class BoardTimerController: NSObject {
    
    private lazy var _flipFlopTimers: [[FlipFlopTimer]] = { [unowned self] in
        
        let idle = self.gameConfig.latencyBetweenTimers
        let running = self.gameConfig.timeTargetAppersOnScreen
        
        var timers = [[FlipFlopTimer]]()
        
        for row in 0..<self.size.rows {
            
            var timerRow = [FlipFlopTimer]()
            
            for column in 0..<self.size.columns {
                var timer = FlipFlopTimer(row: row, column: column, withIdleIntervalRange: idle, withRunningIntervalRange: running)
                timer.timerDelegate = self
                timerRow.append(timer)
            }
            timers.append(timerRow)
        }
        return timers
    }()
    
    weak var delegate: BoardTimerControllerDelegate?
    
    private var gameConfig: GameConfig
    
    var isOnTimePanelty = false
    
    var isOnTimeBonus = false
    
    let size: BoardSize
    
    init(size: BoardSize, gameConfig: GameConfig) {
        self.size = size
        self.gameConfig = gameConfig
    }
    
    func start() {
        initializeTimers()
    }
    
    func stop() {
        invalidateTimers()
    }
    
    func initializeTimers() {
        for row in 0..<size.rows {
            for column in 0..<size.columns {
                _flipFlopTimers[row][column].start()
            }
        }
    }
    
    private func invalidateTimers() {
        
        for row in 0..<size.rows {
            for column in 0..<size.columns {
                print("timer controller is invalidating timer at \(row), \(column)")
                _flipFlopTimers[row][column].stop()
            }
        }
    }
    
    func resetTimerAt(_ row: Int, _ column: Int) {
        _flipFlopTimers[row][column].reset()
    }
    
}

extension BoardTimerController: FliFlopTimerDelegate {
    
    func timerRunningAt(_ row: Int, _ column: Int) {
        // print("timer controller recieved a message that \(row) \(column) is running")
        self.delegate?.cellTimerRunningAt(row, column)
    }
    
    func timerIdleAt(_ row: Int, _ column: Int) {
        // print("timer controller recieved a message that \(row) \(column) is idle")
        self.delegate?.cellTimerIdleAt(row, column)
    }
}
